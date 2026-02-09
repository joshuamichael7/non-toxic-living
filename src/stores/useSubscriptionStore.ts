import { create } from 'zustand';
import { supabase } from '@/lib/supabase';
import {
  getCustomerInfo,
  getTierFromCustomerInfo,
  type SubscriptionTier,
} from '@/services/purchases/RevenueCatService';

interface SubscriptionState {
  tier: SubscriptionTier;
  isLoading: boolean;

  initialize: () => Promise<void>;
  refreshSubscription: () => Promise<void>;
  setTier: (tier: SubscriptionTier) => void;
}

export const useSubscriptionStore = create<SubscriptionState>((set) => ({
  tier: 'free',
  isLoading: true,

  initialize: async () => {
    try {
      // 1. Read from Supabase profile (fast, always available)
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { data: profile } = await (supabase as any)
          .from('profiles')
          .select('subscription')
          .eq('id', user.id)
          .single();

        if (profile?.subscription) {
          set({ tier: profile.subscription as SubscriptionTier });
        }
      }

      // 2. Cross-check with RevenueCat (authoritative source)
      const customerInfo = await getCustomerInfo();
      if (customerInfo) {
        const rcTier = getTierFromCustomerInfo(customerInfo);
        set({ tier: rcTier });
      }
    } catch (error) {
      console.error('Failed to initialize subscription:', error);
    } finally {
      set({ isLoading: false });
    }
  },

  refreshSubscription: async () => {
    try {
      const customerInfo = await getCustomerInfo();
      if (customerInfo) {
        const tier = getTierFromCustomerInfo(customerInfo);
        set({ tier });
      }
    } catch (error) {
      console.error('Failed to refresh subscription:', error);
    }
  },

  setTier: (tier: SubscriptionTier) => set({ tier }),
}));
