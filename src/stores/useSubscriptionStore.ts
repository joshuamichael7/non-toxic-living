import { create } from 'zustand';
import { supabase } from '@/lib/supabase';
import {
  getCustomerInfo,
  getTierFromCustomerInfo,
  getBillingInfoFromCustomerInfo,
  addSubscriptionListener,
  type SubscriptionTier,
  type BillingPeriod,
} from '@/services/purchases/RevenueCatService';

interface SubscriptionState {
  tier: SubscriptionTier;
  billingPeriod: BillingPeriod | null;
  willRenew: boolean;
  expirationDate: string | null;
  activePlanId: string;
  pendingPlanId: string | null;
  pendingEffectiveDate: string | null;
  isLoading: boolean;

  initialize: () => Promise<void>;
  refreshSubscription: () => Promise<void>;
  cancelPendingChange: () => Promise<void>;
  setTier: (tier: SubscriptionTier) => void;
}

function buildPlanId(tier: SubscriptionTier, billingPeriod: BillingPeriod | null): string {
  if (tier === 'free') return 'free';
  return `${tier}_${billingPeriod || 'monthly'}`;
}

// Keep track of listener cleanup
let listenerCleanup: (() => void) | null = null;

/**
 * Shared logic: read RevenueCat + DB, sync store and DB.
 * Called by initialize(), refreshSubscription(), and the real-time listener.
 */
async function syncFromRevenueCat(
  set: (partial: Partial<SubscriptionState>) => void,
) {
  const { data: { user } } = await supabase.auth.getUser();

  // 1. Read pending from DB
  let pendingPlanId: string | null = null;
  let pendingEffectiveDate: string | null = null;
  let dbSubscription: string | null = null;
  let dbSubscriptionPlan: string | null = null;

  if (user) {
    const { data: profile } = await (supabase as any)
      .from('profiles')
      .select('subscription, subscription_plan, pending_subscription, pending_subscription_effective_at')
      .eq('id', user.id)
      .single() as { data: {
        subscription: string;
        subscription_plan: string | null;
        pending_subscription: string | null;
        pending_subscription_effective_at: string | null;
      } | null };

    dbSubscription = profile?.subscription || null;
    dbSubscriptionPlan = profile?.subscription_plan || null;
    pendingPlanId = profile?.pending_subscription || null;
    pendingEffectiveDate = profile?.pending_subscription_effective_at || null;

    console.log('[Sub:Sync] DB state:', JSON.stringify({
      subscription: dbSubscription,
      subscription_plan: dbSubscriptionPlan,
      pending: pendingPlanId,
    }));
  }

  // 2. Read RevenueCat (fresh, cache invalidated)
  const customerInfo = await getCustomerInfo();
  if (!customerInfo) {
    console.log('[Sub:Sync] No customerInfo from RevenueCat');
    set({ pendingPlanId, pendingEffectiveDate });
    return;
  }

  const tier = getTierFromCustomerInfo(customerInfo);
  const billingInfo = getBillingInfoFromCustomerInfo(customerInfo);
  const activePlanId = buildPlanId(tier, billingInfo.billingPeriod);

  console.log('[Sub:Sync] RevenueCat → tier=%s, period=%s, planId=%s, willRenew=%s',
    tier, billingInfo.billingPeriod, activePlanId, billingInfo.willRenew);

  // 3. If active plan matches pending, the change already took effect — clear pending
  if (pendingPlanId && pendingPlanId === activePlanId) {
    console.log('[Sub:Sync] Pending matches active — clearing pending');
    pendingPlanId = null;
    pendingEffectiveDate = null;
  }

  // 4. Update store
  set({
    tier,
    billingPeriod: billingInfo.billingPeriod,
    willRenew: billingInfo.willRenew,
    expirationDate: billingInfo.expirationDate,
    activePlanId,
    pendingPlanId,
    pendingEffectiveDate,
  });

  // 5. Sync DB to match RevenueCat
  if (user) {
    const updates: Record<string, any> = {};
    if (dbSubscription !== tier) {
      updates.subscription = tier;
    }
    if (dbSubscriptionPlan !== activePlanId) {
      updates.subscription_plan = activePlanId;
    }
    // Clear pending in DB if it matched active
    if (pendingPlanId === null && (dbSubscription !== tier || dbSubscriptionPlan !== activePlanId)) {
      // Also clear stale pending when we're correcting the DB
      updates.pending_subscription = null;
      updates.pending_subscription_effective_at = null;
    }

    if (Object.keys(updates).length > 0) {
      console.log('[Sub:Sync] Updating DB:', JSON.stringify(updates));
      await (supabase as any)
        .from('profiles')
        .update(updates)
        .eq('id', user.id);
    } else {
      console.log('[Sub:Sync] DB already in sync');
    }
  }
}

export const useSubscriptionStore = create<SubscriptionState>((set, get) => ({
  tier: 'free',
  billingPeriod: null,
  willRenew: false,
  expirationDate: null,
  activePlanId: 'free',
  pendingPlanId: null,
  pendingEffectiveDate: null,
  isLoading: true,

  initialize: async () => {
    try {
      await syncFromRevenueCat(set);

      // Set up real-time listener for external changes
      // (renewals, cancellations, plan changes made outside the app)
      if (listenerCleanup) {
        listenerCleanup();
      }
      listenerCleanup = addSubscriptionListener(async (_info) => {
        console.log('[Sub:Listener] RevenueCat pushed an update — syncing...');
        try {
          await syncFromRevenueCat(set);
        } catch (err) {
          console.error('[Sub:Listener] Error syncing:', err);
        }
      });
    } catch (error) {
      console.error('Failed to initialize subscription:', error);
    } finally {
      set({ isLoading: false });
    }
  },

  refreshSubscription: async () => {
    console.log('[Sub:Refresh] Manual refresh triggered');
    try {
      await syncFromRevenueCat(set);
    } catch (error) {
      console.error('[Sub:Refresh] Error:', error);
    }
  },

  cancelPendingChange: async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      await (supabase as any)
        .from('profiles')
        .update({
          pending_subscription: null,
          pending_subscription_effective_at: null,
        })
        .eq('id', user.id);

      set({ pendingPlanId: null, pendingEffectiveDate: null });
    } catch (error) {
      console.error('Failed to cancel pending change:', error);
    }
  },

  setTier: (tier: SubscriptionTier) => set({ tier }),
}));
