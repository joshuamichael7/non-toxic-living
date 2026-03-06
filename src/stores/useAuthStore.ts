import { create } from 'zustand';
import { supabase } from '@/lib/supabase';
import { usePreferencesStore } from '@/stores/usePreferencesStore';
import type { Session, User } from '@supabase/supabase-js';

interface AuthState {
  session: Session | null;
  user: User | null;
  isLoading: boolean;
  error: string | null;

  initialize: () => Promise<void>;
  signIn: (email: string, password: string) => Promise<{ error?: string }>;
  signUp: (email: string, password: string, name?: string) => Promise<{ error?: string }>;
  signOut: () => Promise<void>;
  clearError: () => void;
}

export const useAuthStore = create<AuthState>((set, get) => ({
  session: null,
  user: null,
  isLoading: true,
  error: null,

  initialize: async () => {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      set({
        session,
        user: session?.user ?? null,
        isLoading: false,
      });

      // Listen for auth state changes.
      // Guard SIGNED_OUT: a pending signOut() can fire SIGNED_OUT after a new
      // SIGNED_IN (user signs out then back in before signOut acquires the lock).
      // In that case the store already has the new user — don't clear it.
      supabase.auth.onAuthStateChange((event, session) => {
        if (event === 'SIGNED_OUT' && get().user) {
          console.log('[Auth] Ignoring stale SIGNED_OUT — user already signed in');
          return;
        }
        set({
          session,
          user: session?.user ?? null,
        });
      });
    } catch {
      set({ isLoading: false });
    }
  },

  signIn: async (email: string, password: string) => {
    console.log('[Auth] signIn called with email:', email);
    set({ isLoading: true, error: null });
    const { data, error } = await supabase.auth.signInWithPassword({ email, password });

    console.log('[Auth] signInWithPassword result:', { error: error?.message, hasSession: !!data?.session, userId: data?.session?.user?.id });

    if (error) {
      console.log('[Auth] signIn error:', error.message);
      set({ isLoading: false, error: error.message });
      return { error: error.message };
    }

    console.log('[Auth] Setting user in store:', data.session?.user?.id);
    set({
      isLoading: false,
      session: data.session,
      user: data.session?.user ?? null,
    });
    console.log('[Auth] Store user after set:', get().user?.id);
    return {};
  },

  signUp: async (email: string, password: string, name?: string) => {
    set({ isLoading: true, error: null });
    const language = usePreferencesStore.getState().language;
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { language, display_name: name, terms_accepted_at: new Date().toISOString() } },
    });

    if (error) {
      set({ isLoading: false, error: error.message });
      return { error: error.message };
    }

    set({ isLoading: false });
    return {};
  },

  signOut: async () => {
    // Clear auth state immediately for instant UI feedback.
    set({ session: null, user: null });
    // Reset credits to 0 immediately. fetchCredits() reads the auth store user,
    // so now that user is null it will return 0 — but calling initialize() here
    // ensures the credit store updates without waiting for the delayed SIGNED_OUT event.
    const { useCreditStore } = await import('@/stores/useSubscriptionStore');
    useCreditStore.getState().initialize();
    // scope: 'local' clears AsyncStorage without a server call so the Supabase JS
    // async lock is released quickly. Fire-and-forget because the SIGNED_OUT handler
    // guards against stale events that arrive after a new sign-in.
    supabase.auth.signOut({ scope: 'local' }).catch(() => {});
  },

  clearError: () => set({ error: null }),
}));
