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
import { useSubscriptionStore } from '@/stores/useSubscriptionStore';
import { initializePurchases, loginUser, logoutUser } from '@/services/purchases/RevenueCatService';
import { supabase } from '@/lib/supabase';

/** Extract tokens from a deep link URL and set the Supabase session */
function handleAuthDeepLink(url: string) {
  // The URL arrives as nontoxicliving://auth/callback#access_token=...&refresh_token=...
  const fragment = url.split('#')[1];
  if (!fragment) return;

  const params = new URLSearchParams(fragment);
  const accessToken = params.get('access_token');
  const refreshToken = params.get('refresh_token');

  if (accessToken && refreshToken) {
    supabase.auth.setSession({ access_token: accessToken, refresh_token: refreshToken });
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

      // Initialize subscription store (reads from Supabase + RevenueCat)
      await useSubscriptionStore.getState().initialize();

      // Mark ready and hide splash screen
      setIsReady(true);
      SplashScreen.hideAsync();
    }

    init();

    // Handle deep links for email confirmation
    // Check if app was opened via deep link
    Linking.getInitialURL().then((url) => {
      if (url) handleAuthDeepLink(url);
    });
    // Listen for deep links while app is open
    const linkingSub = Linking.addEventListener('url', ({ url }) => {
      handleAuthDeepLink(url);
    });

    // Listen for auth changes to sync RevenueCat identity
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session?.user) {
        await loginUser(session.user.id);
        await useSubscriptionStore.getState().initialize();
      } else if (event === 'SIGNED_OUT') {
        await logoutUser();
        useSubscriptionStore.getState().setTier('free');
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

    if (user && inAuthGroup) {
      // User just signed in — go to tabs
      console.log('[Layout] User signed in, navigating to tabs');
      router.replace('/(tabs)');
    } else if (!user && !inAuthGroup) {
      // User signed out — go to login
      console.log('[Layout] User signed out, navigating to login');
      router.replace('/(auth)/login');
    }
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
            name="notifications"
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
