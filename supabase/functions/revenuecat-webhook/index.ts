import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const WEBHOOK_SECRET = Deno.env.get('REVENUECAT_WEBHOOK_SECRET') || '';
const SUPABASE_URL = Deno.env.get('SUPABASE_URL') || '';
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';

/** Return the number of credits to add for a given product ID, or null if unknown. */
function creditsForProduct(productId: string): number | null {
  if (productId.includes('ntl_credits_500')) return 500;
  if (productId.includes('ntl_credits_200')) return 200;
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

  console.log('RevenueCat webhook:', { eventType, appUserId, productId });

  if (!appUserId) {
    console.error('Missing app_user_id');
    return new Response('Missing app_user_id', { status: 400 });
  }

  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

  try {
    switch (eventType) {
      case 'NON_RENEWING_PURCHASE': {
        const credits = creditsForProduct(productId);
        if (credits === null) {
          console.error('Unknown product ID:', productId);
          break;
        }

        const { error: rpcError } = await supabase.rpc('add_scan_credits', {
          user_uuid: appUserId,
          amount: credits,
        });

        if (rpcError) {
          console.error('Failed to add credits:', rpcError);
          return new Response('Database error', { status: 500 });
        }

        console.log(`Credits added: ${appUserId} +${credits}`);
        break;
      }

      default: {
        console.log(`Unhandled event type: ${eventType}`);
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
