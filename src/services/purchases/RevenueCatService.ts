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
    return offerings.current;
  } catch (error) {
    console.error('Failed to get offerings:', error);
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
  try {
    const { customerInfo } = await Purchases.purchasePackage(pkg);
    // Sync to Supabase as safety net (webhook is authoritative)
    const tier = getTierFromCustomerInfo(customerInfo);
    const expiresAt = getExpirationFromCustomerInfo(customerInfo);
    await syncToSupabase(tier, expiresAt);
    return customerInfo;
  } catch (error: any) {
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
    return await Purchases.getCustomerInfo();
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
  if (info.entitlements.active['power_access']) {
    return 'power';
  }
  if (info.entitlements.active['pro_access']) {
    return 'pro';
  }
  return 'free';
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
 * Sync subscription state to Supabase profiles table.
 * This is a client-side safety net — the webhook is the authoritative source.
 */
async function syncToSupabase(
  tier: SubscriptionTier,
  expiresAt: string | null,
): Promise<void> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    await (supabase as any)
      .from('profiles')
      .update({
        subscription: tier,
        subscription_expires_at: expiresAt,
      })
      .eq('id', user.id);
  } catch (error) {
    console.error('Failed to sync subscription to Supabase:', error);
  }
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
