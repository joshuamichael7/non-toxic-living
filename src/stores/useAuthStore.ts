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

      // Listen for auth state changes
      supabase.auth.onAuthStateChange((_event, session) => {
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
      options: { data: { language, display_name: name } },
    });

    if (error) {
      set({ isLoading: false, error: error.message });
      return { error: error.message };
    }

    set({ isLoading: false });
    return {};
  },

  signOut: async () => {
    await supabase.auth.signOut();
    set({ session: null, user: null });
  },

  clearError: () => set({ error: null }),
}));
