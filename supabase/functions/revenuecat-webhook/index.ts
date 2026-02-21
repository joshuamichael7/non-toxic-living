import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const WEBHOOK_SECRET = Deno.env.get('REVENUECAT_WEBHOOK_SECRET') || '';
const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || '';
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';

// Full plan ordering: higher = upgrade, lower = downgrade
// monthly→annual on same tier = upgrade (immediate on iOS)
// annual→monthly on same tier = downgrade (deferred on iOS)
const PLAN_ORDER: Record<string, number> = {
  'free': 0,
  'pro_monthly': 1,
  'pro_annual': 2,
  'power_monthly': 3,
  'power_annual': 4,
};

// Extract tier from plan ID: 'pro_monthly' → 'pro'
function planToTier(planId: string): string {
  if (planId.startsWith('power')) return 'power';
  if (planId.startsWith('pro')) return 'pro';
  return 'free';
}

// Map RevenueCat product ID to our plan ID
function productIdToPlanId(productId: string): string | null {
  if (productId.includes('ntl_pro') && productId.includes('annual')) return 'pro_annual';
  if (productId.includes('ntl_pro')) return 'pro_monthly';
  if (productId.includes('ntl_power') && productId.includes('annual')) return 'power_annual';
  if (productId.includes('ntl_power')) return 'power_monthly';
  return null;
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405 });
  }

  const authHeader = req.headers.get('authorization') || '';
  if (WEBHOOK_SECRET && authHeader !== `Bearer ${WEBHOOK_SECRET}`) {
    console.error('Invalid webhook authorization');
    return new Response('Unauthorized', { status: 401 });
  }

  let body: any;
  try {
    body = await req.json();
  } catch {
    return new Response('Invalid JSON', { status: 400 });
  }

  const event = body?.event;
  if (!event) {
    return new Response('Missing event', { status: 400 });
  }

  const eventType = event.type;
  const appUserId = event.app_user_id;
  const productId = event.product_id || '';
  const expirationAtMs = event.expiration_at_ms;

  console.log('RevenueCat webhook:', { eventType, appUserId, productId });

  if (!appUserId) {
    console.error('Missing app_user_id');
    return new Response('Missing app_user_id', { status: 400 });
  }

  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

  try {
    switch (eventType) {
      case 'INITIAL_PURCHASE':
      case 'NON_RENEWING_PURCHASE': {
        const newPlanId = productIdToPlanId(productId);
        if (!newPlanId) {
          console.error('Unknown product:', productId);
          break;
        }

        const expiresAt = expirationAtMs ? new Date(expirationAtMs).toISOString() : null;
        const resetDate = new Date();
        resetDate.setMonth(resetDate.getMonth() + 1);

        const { error } = await supabase
          .from('profiles')
          .update({
            subscription: planToTier(newPlanId),
            subscription_plan: newPlanId,
            subscription_expires_at: expiresAt,
            scans_this_month: 0,
            scans_month_reset_at: resetDate.toISOString(),
            pending_subscription: null,
            pending_subscription_effective_at: null,
          })
          .eq('id', appUserId);

        if (error) {
          console.error('Failed to update profile:', error);
          return new Response('Database error', { status: 500 });
        }
        console.log(`Initial purchase: ${appUserId} → ${newPlanId}`);
        break;
      }

      case 'PRODUCT_CHANGE': {
        const newPlanId = productIdToPlanId(productId);
        if (!newPlanId) {
          console.error('Unknown product:', productId);
          break;
        }

        // Get current plan from database
        const { data: profile } = await supabase
          .from('profiles')
          .select('subscription, subscription_plan')
          .eq('id', appUserId)
          .single();

        const currentPlanId = profile?.subscription_plan || profile?.subscription || 'free';
        const currentOrder = PLAN_ORDER[currentPlanId] ?? 0;
        const newOrder = PLAN_ORDER[newPlanId] ?? 0;
        const isUpgrade = newOrder > currentOrder;

        const expiresAt = expirationAtMs ? new Date(expirationAtMs).toISOString() : null;

        if (isUpgrade) {
          // Upgrade: immediate — update active plan, reset quota, clear pending
          const resetDate = new Date();
          resetDate.setMonth(resetDate.getMonth() + 1);

          const { error } = await supabase
            .from('profiles')
            .update({
              subscription: planToTier(newPlanId),
              subscription_plan: newPlanId,
              subscription_expires_at: expiresAt,
              scans_this_month: 0,
              scans_month_reset_at: resetDate.toISOString(),
              pending_subscription: null,
              pending_subscription_effective_at: null,
            })
            .eq('id', appUserId);

          if (error) {
            console.error('Failed to update profile:', error);
            return new Response('Database error', { status: 500 });
          }
          console.log(`Upgrade: ${appUserId} ${currentPlanId} → ${newPlanId}`);
        } else {
          // Downgrade: deferred — store as pending only
          const { error } = await supabase
            .from('profiles')
            .update({
              pending_subscription: newPlanId,
              pending_subscription_effective_at: expiresAt,
            })
            .eq('id', appUserId);

          if (error) {
            console.error('Failed to set pending:', error);
            return new Response('Database error', { status: 500 });
          }
          console.log(`Pending: ${appUserId} ${currentPlanId} → ${newPlanId} on ${expiresAt}`);
        }
        break;
      }

      case 'RENEWAL': {
        const newPlanId = productIdToPlanId(productId);
        if (!newPlanId) {
          console.error('Unknown product:', productId);
          break;
        }
        const expiresAt = expirationAtMs ? new Date(expirationAtMs).toISOString() : null;

        const { error } = await supabase
          .from('profiles')
          .update({
            subscription: planToTier(newPlanId),
            subscription_plan: newPlanId,
            subscription_expires_at: expiresAt,
            pending_subscription: null,
            pending_subscription_effective_at: null,
          })
          .eq('id', appUserId);

        if (error) {
          console.error('Failed to update on renewal:', error);
          return new Response('Database error', { status: 500 });
        }
        console.log(`Renewal: ${appUserId} → ${newPlanId}`);
        break;
      }

      case 'CANCELLATION':
      case 'EXPIRATION': {
        const { error } = await supabase
          .from('profiles')
          .update({
            subscription: 'free',
            subscription_plan: 'free',
            subscription_expires_at: null,
            pending_subscription: null,
            pending_subscription_effective_at: null,
          })
          .eq('id', appUserId);

        if (error) {
          console.error('Failed to downgrade:', error);
          return new Response('Database error', { status: 500 });
        }
        console.log(`Expired: ${appUserId} → free`);
        break;
      }

      case 'BILLING_ISSUES_DETECTED': {
        console.warn(`Billing issue for ${appUserId}`);
        break;
      }

      default: {
        console.log(`Unhandled: ${eventType}`);
      }
    }
  } catch (error) {
    console.error('Webhook error:', error);
    return new Response('Internal error', { status: 500 });
  }

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
