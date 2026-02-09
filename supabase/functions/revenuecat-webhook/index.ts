import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const WEBHOOK_SECRET = Deno.env.get('REVENUECAT_WEBHOOK_SECRET') || '';
const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || '';
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';

// Map RevenueCat product IDs to our tier names
function productIdToTier(productId: string): 'pro' | 'power' | null {
  if (productId.includes('ntl_pro')) return 'pro';
  if (productId.includes('ntl_power')) return 'power';
  return null;
}

Deno.serve(async (req: Request) => {
  // Only accept POST
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405 });
  }

  // Verify webhook authorization
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

  // Create Supabase admin client
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

  try {
    switch (eventType) {
      case 'INITIAL_PURCHASE':
      case 'RENEWAL':
      case 'PRODUCT_CHANGE':
      case 'NON_RENEWING_PURCHASE': {
        const tier = productIdToTier(productId);
        if (!tier) {
          console.error('Unknown product:', productId);
          break;
        }

        const expiresAt = expirationAtMs
          ? new Date(expirationAtMs).toISOString()
          : null;

        const { error } = await supabase
          .from('profiles')
          .update({
            subscription: tier,
            subscription_expires_at: expiresAt,
          })
          .eq('id', appUserId);

        if (error) {
          console.error('Failed to update profile:', error);
          return new Response('Database error', { status: 500 });
        }

        console.log(`Updated user ${appUserId} to ${tier}, expires: ${expiresAt}`);
        break;
      }

      case 'CANCELLATION':
      case 'EXPIRATION': {
        const { error } = await supabase
          .from('profiles')
          .update({
            subscription: 'free',
            subscription_expires_at: null,
          })
          .eq('id', appUserId);

        if (error) {
          console.error('Failed to downgrade profile:', error);
          return new Response('Database error', { status: 500 });
        }

        console.log(`Downgraded user ${appUserId} to free`);
        break;
      }

      case 'BILLING_ISSUES_DETECTED': {
        // Log but don't downgrade yet — Apple/Google have grace periods
        console.warn(`Billing issue for user ${appUserId}`);
        break;
      }

      default: {
        console.log(`Unhandled event type: ${eventType}`);
      }
    }
  } catch (error) {
    console.error('Webhook processing error:', error);
    return new Response('Internal error', { status: 500 });
  }

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
