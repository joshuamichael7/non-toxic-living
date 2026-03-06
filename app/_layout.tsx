import { useEffect, useRef, useState } from 'react';
import { Stack, Redirect, useRouter, useSegments } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import * as SplashScreen from 'expo-splash-screen';
import * as Linking from 'expo-linking';
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

// Set to true when a password recovery deep link is being processed so the
// navigation effect doesn't redirect to tabs mid-flow.
let _recoveryInProgress = false;

/** Extract tokens from a deep link URL.
 *
 *  For recovery links: store the access token for the reset-password screen to
 *  consume and set _recoveryInProgress — but do NOT call setSession.
 *  Calling setSession hangs on a network call to /auth/v1/user which holds the
 *  Supabase JS internal async lock, blocks all subsequent auth calls, and can
 *  cause spurious SIGNED_OUT events that corrupt the auth client state.
 *
 *  For all other links (email confirmation etc.): call setSession as normal.
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
    // Store token for the reset-password screen to consume, then let Expo
    // Router handle navigation to /(auth)/reset-password via the URL path.
    _recoveryInProgress = true;
    console.log('[Layout] recovery deep link — storing token, NOT calling setSession');
    storeRecoveryToken(accessToken);
    return;
  }

  if (accessToken && refreshToken) {
    console.log('[Layout] calling setSession...');
    const { error } = await supabase.auth.setSession({ access_token: accessToken, refresh_token: refreshToken });
    console.log('[Layout] setSession done, error:', error?.message ?? 'none');
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
      // Initialize auth
      await useAuthStore.getState().initialize();

      // Sync persisted language to i18n on app start
      usePreferencesStore.getState();

      // Initialize RevenueCat with user ID
      const currentUser = useAuthStore.getState().user;
      await initializePurchases(currentUser?.id);

      // Initialize credit store (reads scan_credits from Supabase)
      await useCreditStore.getState().initialize();

      // Mark ready and hide splash screen
      setIsReady(true);
      SplashScreen.hideAsync();
    }

    init();

    // Handle deep links for email confirmation / password recovery
    Linking.getInitialURL().then((url) => {
      if (url) handleAuthDeepLink(url);
    });
    const linkingSub = Linking.addEventListener('url', ({ url }) => {
      handleAuthDeepLink(url);
    });

    // Listen for auth changes to sync RevenueCat identity
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session?.user) {
        await loginUser(session.user.id);
        await useCreditStore.getState().initialize();
        queryClient.clear(); // flush cached data so new user sees fresh data
      } else if (event === 'SIGNED_OUT') {
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
