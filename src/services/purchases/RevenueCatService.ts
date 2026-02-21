import Purchases, {
  type PurchasesOffering,
  type PurchasesPackage,
  type CustomerInfo,
  LOG_LEVEL,
} from 'react-native-purchases';
import { Platform } from 'react-native';
import { supabase } from '@/lib/supabase';

const IOS_KEY = process.env.EXPO_PUBLIC_REVENUECAT_IOS_KEY || '';
const ANDROID_KEY = process.env.EXPO_PUBLIC_REVENUECAT_ANDROID_KEY || '';

export type SubscriptionTier = 'free' | 'pro' | 'power';
export type BillingPeriod = 'monthly' | 'annual';

export interface BillingInfo {
  billingPeriod: BillingPeriod | null;
  willRenew: boolean;
  expirationDate: string | null;
}

/**
 * Initialize RevenueCat SDK.
 * Call once at app startup after auth is ready.
 * Uses Supabase user ID as the RevenueCat appUserID.
 */
export async function initializePurchases(userId?: string): Promise<void> {
  const apiKey = Platform.OS === 'ios' ? IOS_KEY : ANDROID_KEY;

  if (!apiKey) {
    console.warn('RevenueCat API key not configured');
    return;
  }

  if (__DEV__) {
    Purchases.setLogLevel(LOG_LEVEL.DEBUG);
  }

  await Purchases.configure({ apiKey, appUserID: userId || undefined });
  console.log('RevenueCat initialized', { platform: Platform.OS, userId: userId ?? 'anonymous' });
}

/**
 * Get current offerings (available subscription packages).
 */
export async function getOfferings(): Promise<PurchasesOffering | null> {
  try {
    const offerings = await Purchases.getOfferings();
    const current = offerings.current;
    if (current) {
      console.log('[Offerings] Current offering:', current.identifier);
      console.log('[Offerings] Packages:', current.availablePackages.map(p => ({
        id: p.identifier,
        productId: p.product.identifier,
        price: p.product.priceString,
        subscriptionPeriod: p.product.subscriptionPeriod,
      })));
    } else {
      console.log('[Offerings] No current offering found');
    }
    return current;
  } catch (error) {
    console.error('[Offerings] Failed to get offerings:', error);
    return null;
  }
}

/**
 * Purchase a subscription package.
 * Returns CustomerInfo on success, null if user cancelled.
 * Throws on error.
 */
export async function purchasePackage(
  pkg: PurchasesPackage,
): Promise<CustomerInfo | null> {
  console.log('[Purchase] Starting purchase:', {
    packageId: pkg.identifier,
    productId: pkg.product.identifier,
    price: pkg.product.priceString,
    offeringId: pkg.offeringIdentifier,
  });
  try {
    const { customerInfo } = await Purchases.purchasePackage(pkg);
    console.log('[Purchase] Success:', {
      activeEntitlements: Object.keys(customerInfo.entitlements.active),
    });
    // Sync to Supabase as safety net (webhook is authoritative)
    const tier = getTierFromCustomerInfo(customerInfo);
    const expiresAt = getExpirationFromCustomerInfo(customerInfo);
    await syncToSupabase(tier, expiresAt);
    return customerInfo;
  } catch (error: any) {
    console.log('[Purchase] Error:', {
      code: error.code,
      message: error.message,
      userCancelled: error.userCancelled,
      underlyingErrorMessage: error.underlyingErrorMessage,
      readableErrorCode: error.readableErrorCode,
      raw: JSON.stringify(error, null, 2),
    });
    if (error.userCancelled) {
      return null;
    }
    throw error;
  }
}

/**
 * Restore previous purchases (for reinstalls or device switches).
 */
export async function restorePurchases(): Promise<CustomerInfo> {
  const customerInfo = await Purchases.restorePurchases();
  const tier = getTierFromCustomerInfo(customerInfo);
  const expiresAt = getExpirationFromCustomerInfo(customerInfo);
  await syncToSupabase(tier, expiresAt);
  return customerInfo;
}

/**
 * Get current customer info without making a purchase.
 */
export async function getCustomerInfo(): Promise<CustomerInfo | null> {
  try {
    // Always invalidate cache first so we get fresh data from RevenueCat servers,
    // not stale device-side cache that doesn't reflect recent plan changes.
    await Purchases.invalidateCustomerInfoCache();
    const info = await Purchases.getCustomerInfo();

    // Log everything RevenueCat tells us
    const activeEntitlements = Object.entries(info.entitlements.active).map(([key, ent]) => ({
      entitlement: key,
      productIdentifier: ent.productIdentifier,
      willRenew: ent.willRenew,
      expirationDate: ent.expirationDate,
      isActive: ent.isActive,
      isSandbox: ent.isSandbox,
    }));
    const allEntitlements = Object.entries(info.entitlements.all).map(([key, ent]) => ({
      entitlement: key,
      productIdentifier: ent.productIdentifier,
      isActive: ent.isActive,
    }));
    console.log('[RC:CustomerInfo] ===== REVENUECAT STATE =====');
    console.log('[RC:CustomerInfo] Active entitlements:', JSON.stringify(activeEntitlements, null, 2));
    console.log('[RC:CustomerInfo] All entitlements:', JSON.stringify(allEntitlements, null, 2));
    console.log('[RC:CustomerInfo] Active subscriptions:', JSON.stringify(info.activeSubscriptions));
    console.log('[RC:CustomerInfo] All purchased product IDs:', JSON.stringify(info.allPurchasedProductIdentifiers));

    return info;
  } catch (error) {
    console.error('Failed to get customer info:', error);
    return null;
  }
}

/**
 * Map RevenueCat entitlements to our tier system.
 * power_access > pro_access > free
 */
export function getTierFromCustomerInfo(info: CustomerInfo): SubscriptionTier {
  const hasPower = !!info.entitlements.active['power_access'];
  const hasPro = !!info.entitlements.active['pro_access'];
  const result = hasPower ? 'power' : hasPro ? 'pro' : 'free';
  console.log(`[RC:Tier] power_access=${hasPower}, pro_access=${hasPro} → tier=${result}`);
  return result;
}

/**
 * Get expiration date from the active entitlement.
 */
function getExpirationFromCustomerInfo(info: CustomerInfo): string | null {
  const powerEntitlement = info.entitlements.active['power_access'];
  if (powerEntitlement?.expirationDate) {
    return powerEntitlement.expirationDate;
  }
  const proEntitlement = info.entitlements.active['pro_access'];
  if (proEntitlement?.expirationDate) {
    return proEntitlement.expirationDate;
  }
  return null;
}

/**
 * Extract billing info (period, willRenew, expiration) from active entitlements.
 * Uses productIdentifier to determine monthly vs annual.
 */
export function getBillingInfoFromCustomerInfo(info: CustomerInfo): BillingInfo {
  const entitlement =
    info.entitlements.active['power_access'] ||
    info.entitlements.active['pro_access'];

  if (!entitlement) {
    return { billingPeriod: null, willRenew: false, expirationDate: null };
  }

  const isAnnual = entitlement.productIdentifier.includes('annual');
  return {
    billingPeriod: isAnnual ? 'annual' : 'monthly',
    willRenew: entitlement.willRenew,
    expirationDate: entitlement.expirationDate,
  };
}

/**
 * Sync subscription state to Supabase profiles table.
 * This is a client-side safety net — the webhook is the authoritative source.
 * On upgrade from free, also resets scan quota and starts a fresh billing cycle.
 */
async function syncToSupabase(
  tier: SubscriptionTier,
  expiresAt: string | null,
): Promise<void> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    // Check current tier to detect upgrades
    const { data: profile } = await (supabase as any)
      .from('profiles')
      .select('subscription')
      .eq('id', user.id)
      .single() as { data: { subscription: string } | null };

    const isUpgrade = profile && profile.subscription !== tier && tier !== 'free';

    const updateData: Record<string, any> = {
      subscription: tier,
      subscription_expires_at: expiresAt,
    };

    // Reset scan quota on upgrade so user gets full allotment immediately
    if (isUpgrade) {
      const resetDate = new Date();
      resetDate.setMonth(resetDate.getMonth() + 1);
      updateData.scans_this_month = 0;
      updateData.scans_month_reset_at = resetDate.toISOString();
    }

    await (supabase as any)
      .from('profiles')
      .update(updateData)
      .eq('id', user.id);
  } catch (error) {
    console.error('Failed to sync subscription to Supabase:', error);
  }
}

/**
 * Add a listener for real-time subscription changes.
 * Fires when RevenueCat SDK receives updates (renewals, cancellations, external changes).
 * Returns an unsubscribe function.
 */
export function addSubscriptionListener(
  onUpdate: (info: CustomerInfo) => void
): () => void {
  const wrappedListener = (info: CustomerInfo) => {
    console.log('[RC:Listener] Customer info updated — active entitlements:',
      Object.keys(info.entitlements.active));
    onUpdate(info);
  };
  Purchases.addCustomerInfoUpdateListener(wrappedListener);
  return () => Purchases.removeCustomerInfoUpdateListener(wrappedListener);
}

/**
 * Identify user to RevenueCat (call on login).
 */
export async function loginUser(userId: string): Promise<void> {
  try {
    await Purchases.logIn(userId);
  } catch (error) {
    console.error('RevenueCat login error:', error);
  }
}

/**
 * Log out from RevenueCat (call on sign out).
 */
export async function logoutUser(): Promise<void> {
  try {
    await Purchases.logOut();
  } catch (error) {
    console.error('RevenueCat logout error:', error);
  }
}
