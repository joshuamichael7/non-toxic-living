import { create } from 'zustand';
import { supabase } from '@/lib/supabase';
import { useAuthStore } from '@/stores/useAuthStore';

interface CreditState {
  credits: number;
  isLoading: boolean;

  initialize: () => Promise<void>;
  refreshCredits: () => Promise<void>;
  decrementCredit: () => void;
}

async function fetchCredits(): Promise<number> {
  // Use the auth store as the source of truth rather than supabase.auth.getUser().
  // The Supabase JS client can still hold the previous session internally when
  // signOut() is fire-and-forget, causing fetchCredits to return the wrong user's data.
  const user = useAuthStore.getState().user;
  if (!user) return 0;

  const { data } = await (supabase as any)
    .from('profiles')
    .select('scan_credits')
    .eq('id', user.id)
    .single() as { data: { scan_credits: number } | null };

  return data?.scan_credits ?? 0;
}

export const useCreditStore = create<CreditState>((set) => ({
  credits: 0,
  isLoading: true,

  initialize: async () => {
    try {
      const credits = await fetchCredits();
      set({ credits, isLoading: false });
    } catch (error) {
      console.error('[Credits] Failed to initialize:', error);
      set({ isLoading: false });
    }
  },

  refreshCredits: async () => {
    try {
      const credits = await fetchCredits();
      set({ credits });
      console.log('[Credits] Refreshed:', credits);
    } catch (error) {
      console.error('[Credits] Failed to refresh:', error);
    }
  },

  decrementCredit: () => {
    set((state) => ({ credits: Math.max(0, state.credits - 1) }));
  },
}));

// Backwards-compat alias so any remaining imports of useSubscriptionStore still compile
export const useSubscriptionStore = useCreditStore;
