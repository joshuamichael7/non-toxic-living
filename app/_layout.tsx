import { useEffect, useRef, useState } from 'react';
import { Stack, Redirect, useRouter, useSegments } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import * as SplashScreen from 'expo-splash-screen';
import * as Linking from 'expo-linking';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { GestureHandlerRootView } from 'react-native-gesture-handler';

import '../global.css';
import '@/i18n';
import { usePreferencesStore } from '@/stores/usePreferencesStore';
import { useAuthStore } from '@/stores/useAuthStore';
import { useCreditStore } from '@/stores/useSubscriptionStore';
import { initializePurchases, loginUser, logoutUser } from '@/services/purchases/RevenueCatService';
import { supabase } from '@/lib/supabase';
import { storeRecoveryToken } from '@/lib/recoverySession';

const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!;

// Set to true when a password recovery deep link is being processed so the
// navigation effect doesn't redirect to tabs mid-flow.
let _recoveryInProgress = false;

/** Parse the expiry timestamp from a JWT access token. */
function parseJwtExp(token: string): number {
  try {
    const payload = token.split('.')[1] ?? '';
    const padded = payload + '='.repeat((4 - (payload.length % 4)) % 4);
    const data = JSON.parse(atob(padded.replace(/-/g, '+').replace(/_/g, '/')));
    return typeof data.exp === 'number' ? data.exp : 0;
  } catch {
    return 0;
  }
}

/** Handle magic link tokens without touching the Supabase JS async lock.
 *
 *  setSession() acquires the lock and can hang indefinitely if a background
 *  token refresh or a pending signOut() is holding it. Instead we:
 *  1. Fetch the user directly via REST (no lock needed)
 *  2. Build a session object and persist to AsyncStorage using Supabase's key
 *  3. Update the auth store and downstream services directly
 */
async function handleMagicLinkTokens(accessToken: string, refreshToken: string) {
  console.log('[Layout] magic link — fetching user directly (bypass JS lock)');
  try {
    const controller = new AbortController();
    const to = setTimeout(() => controller.abort(), 10000);
    const res = await fetch(`${supabaseUrl}/auth/v1/user`, {
      headers: { 'Authorization': `Bearer ${accessToken}`, 'apikey': supabaseAnonKey },
      signal: controller.signal,
    });
    clearTimeout(to);

    if (!res.ok) {
      console.log('[Layout] magic link user fetch failed:', res.status);
      return;
    }

    const user = await res.json();
    console.log('[Layout] magic link user:', user.id);

    const expiresAt = parseJwtExp(accessToken) || Math.floor(Date.now() / 1000) + 3600;
    const session = {
      access_token: accessToken,
      token_type: 'bearer',
      expires_in: Math.max(0, expiresAt - Math.floor(Date.now() / 1000)),
      expires_at: expiresAt,
      refresh_token: refreshToken,
      user,
    };

    // Persist to AsyncStorage with Supabase's key so getSession() restores it on restart.
    const ref = supabaseUrl.match(/https?:\/\/([^.]+)/)?.[1] ?? '';
    await AsyncStorage.setItem(`sb-${ref}-auth-token`, JSON.stringify(session));

    // Update the auth store and trigger downstream effects directly —
    // no onAuthStateChange fires since we bypassed setSession().
    useAuthStore.setState({ session: session as any, user, isLoading: false });
    await loginUser(user.id);
    await useCreditStore.getState().initialize();
    queryClient.clear();

    console.log('[Layout] magic link — signed in successfully');
  } catch (err: any) {
    console.log('[Layout] magic link error:', err?.name, err?.message);
  }
}

/** Extract tokens from a deep link URL.
 *
 *  - recovery: store the access token for the reset-password screen and do NOT
 *    call setSession (it hangs on /auth/v1/user and holds the JS lock).
 *  - magiclink: bypass setSession entirely; use handleMagicLinkTokens instead.
 *  - other (email confirmation etc.): call setSession with a timeout.
 */
async function handleAuthDeepLink(url: string) {
  console.log('[Layout] handleAuthDeepLink called:', url.substring(0, 80));
  const fragment = url.split('#')[1];
  if (!fragment) {
    console.log('[Layout] handleAuthDeepLink: no fragment, skipping');
    return;
  }

  const params = new URLSearchParams(fragment);
  const accessToken = params.get('access_token');
  const refreshToken = params.get('refresh_token');
  const type = params.get('type');
  console.log('[Layout] handleAuthDeepLink: type=', type, 'hasTokens=', !!(accessToken && refreshToken));

  if (type === 'recovery' && accessToken) {
    _recoveryInProgress = true;
    console.log('[Layout] recovery deep link — storing token, NOT calling setSession');
    storeRecoveryToken(accessToken);
    return;
  }

  if (type === 'magiclink' && accessToken && refreshToken) {
    await handleMagicLinkTokens(accessToken, refreshToken);
    return;
  }

  if (accessToken && refreshToken) {
    console.log('[Layout] calling setSession (10s timeout)...');
    await Promise.race([
      supabase.auth.setSession({ access_token: accessToken, refresh_token: refreshToken }),
      new Promise<void>(resolve => setTimeout(resolve, 10000)),
    ]);
    console.log('[Layout] setSession done (or timed out)');
  } else {
    console.log('[Layout] handleAuthDeepLink: missing tokens, skipping setSession');
  }
}

// Prevent splash screen from auto-hiding
SplashScreen.preventAutoHideAsync();

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5, // 5 minutes
      gcTime: 1000 * 60 * 60, // 1 hour
    },
  },
});

export default function RootLayout() {
  const [isReady, setIsReady] = useState(false);
  const user = useAuthStore((s) => s.user);

  useEffect(() => {
    async function init() {
      // Initialize auth — registers onAuthStateChange listener so any SIGNED_IN
      // event from handleAuthDeepLink below is captured.
      await useAuthStore.getState().initialize();

      // Sync persisted language to i18n on app start
      usePreferencesStore.getState();

      // Initialize RevenueCat with user ID
      const currentUser = useAuthStore.getState().user;
      await initializePurchases(currentUser?.id);

      // Initialize credit store (reads scan_credits from Supabase)
      await useCreditStore.getState().initialize();

      // Handle cold-start deep link AFTER auth listeners are registered.
      // Previously this ran in parallel with init(), meaning setSession could
      // fire SIGNED_IN before onAuthStateChange was subscribed, dropping the event.
      const initialUrl = await Linking.getInitialURL();
      if (initialUrl) await handleAuthDeepLink(initialUrl);

      // Mark ready and hide splash screen
      setIsReady(true);
      SplashScreen.hideAsync();
    }

    init();

    // Warm-start: handle deep links that arrive while the app is already running.
    const linkingSub = Linking.addEventListener('url', ({ url }) => {
      handleAuthDeepLink(url);
    });

    // Listen for auth changes to sync RevenueCat identity.
    // Guard SIGNED_OUT: a pending signOut() can fire SIGNED_OUT after a subsequent
    // SIGNED_IN (user signs out then back in before signOut acquires the JS lock).
    // In that case we already have a valid user — skip the logout cleanup.
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session?.user) {
        await loginUser(session.user.id);
        await useCreditStore.getState().initialize();
        queryClient.clear(); // flush cached data so new user sees fresh data
      } else if (event === 'SIGNED_OUT') {
        if (useAuthStore.getState().user) {
          console.log('[Layout] Ignoring stale SIGNED_OUT — active session exists');
          return;
        }
        await logoutUser();
        await useCreditStore.getState().initialize();
        queryClient.clear();
      }
    });

    return () => {
      subscription.unsubscribe();
      linkingSub.remove();
    };
  }, []);

  const router = useRouter();
  const segments = useSegments();

  // Navigate based on auth state changes
  useEffect(() => {
    if (!isReady) return;

    const inAuthGroup = segments[0] === '(auth)';
    const isResettingPassword = segments.includes('reset-password');

    // Clear recovery flag once we've left the reset-password screen so that
    // subsequent normal sign-ins (after the reset) redirect to tabs correctly.
    if (_recoveryInProgress && !isResettingPassword) {
      console.log('[Layout] left reset-password screen, clearing _recoveryInProgress');
      _recoveryInProgress = false;
    }

    if (user && inAuthGroup && !isResettingPassword && !_recoveryInProgress) {
      // User just signed in — go to tabs (but not during password recovery)
      console.log('[Layout] User signed in, navigating to tabs');
      router.replace('/(tabs)');
    }
    // Guest users can browse freely — no redirect to login
  }, [user, isReady, segments]);

  // Don't render anything until auth is initialized
  if (!isReady) return null;

  return (
    <QueryClientProvider client={queryClient}>
      <GestureHandlerRootView style={{ flex: 1 }}>
        <Stack
          screenOptions={{
            headerShown: false,
            contentStyle: { backgroundColor: '#FAFAF9' },
          }}
        >
          <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
          <Stack.Screen name="(auth)" options={{ headerShown: false }} />
          <Stack.Screen
            name="result/[id]"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="describe"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="history"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="avoid-list"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="help"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="about"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
          <Stack.Screen
            name="subscription"
            options={{
              presentation: 'modal',
              animation: 'slide_from_bottom',
            }}
          />
        </Stack>
        <StatusBar style="dark" />
      </GestureHandlerRootView>
    </QueryClientProvider>
  );
}
