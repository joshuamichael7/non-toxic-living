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

/** Credits awarded per product identifier */
const CREDITS_BY_PRODUCT: Record<string, number> = {
  ntl_credits_200: 200,
  ntl_credits_500: 500,
};

/**
 * Initialize RevenueCat SDK.
 * Call once at app startup after auth is ready.
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
 * Get the credits offering from RevenueCat.
 * Looks for an offering named "credits", falls back to "current".
 */
export async function getCreditOfferings(): Promise<PurchasesOffering | null> {
  try {
    const offerings = await Purchases.getOfferings();
    const creditsOffering = offerings.all['credits'] || offerings.current;
    if (creditsOffering) {
      console.log('[Offerings] Using offering:', creditsOffering.identifier);
      console.log('[Offerings] Packages:', creditsOffering.availablePackages.map(p => ({
        id: p.identifier,
        productId: p.product.identifier,
        price: p.product.priceString,
      })));
    } else {
      console.log('[Offerings] No offering found');
    }
    return creditsOffering;
  } catch (error) {
    console.error('[Offerings] Failed to get offerings:', error);
    return null;
  }
}

/**
 * Purchase a credit pack.
 * Returns the number of credits awarded on success, null if user cancelled.
 * Throws on error.
 */
export async function purchaseCreditPack(
  pkg: PurchasesPackage,
): Promise<number | null> {
  console.log('[Purchase] Starting credit pack purchase:', {
    packageId: pkg.identifier,
    productId: pkg.product.identifier,
    price: pkg.product.priceString,
  });
  try {
    const { customerInfo } = await Purchases.purchasePackage(pkg);
    console.log('[Purchase] Success. All purchased products:', customerInfo.allPurchasedProductIdentifiers);

    // Determine credits from product ID
    const productId = pkg.product.identifier;
    const credits = Object.entries(CREDITS_BY_PRODUCT).find(
      ([key]) => productId.includes(key)
    )?.[1] ?? 0;

    if (credits > 0) {
      // Client-side safety net: add credits immediately in case webhook is slow
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        await addCreditsAfterPurchase(user.id, credits);
      }
    }

    return credits;
  } catch (error: any) {
    console.log('[Purchase] Error:', {
      code: error.code,
      message: error.message,
      userCancelled: error.userCancelled,
    });
    if (error.userCancelled) {
      return null;
    }
    throw error;
  }
}

/**
 * Add credits to a user's profile.
 * Called as a client-side safety net after a successful purchase,
 * in case the RevenueCat webhook is slow.
 */
export async function addCreditsAfterPurchase(
  userId: string,
  credits: number,
): Promise<number> {
  try {
    const { data, error } = await (supabase as any).rpc('add_scan_credits', {
      user_uuid: userId,
      amount: credits,
    });
    if (error) {
      console.error('[Credits] Failed to add credits:', error);
      return 0;
    }
    console.log('[Credits] Added', credits, '→ new balance:', data);
    return data as number;
  } catch (err) {
    console.error('[Credits] Exception adding credits:', err);
    return 0;
  }
}

/**
 * Restore previous purchases (for reinstalls or device switches).
 * After restoring, the webhook will re-fire or the client can re-add credits.
 */
export async function restorePurchases(): Promise<CustomerInfo> {
  const customerInfo = await Purchases.restorePurchases();
  console.log('[Restore] Restored purchases. Products:', customerInfo.allPurchasedProductIdentifiers);
  return customerInfo;
}

/**
 * Get current customer info (used for restore flow).
 */
export async function getCustomerInfo(): Promise<CustomerInfo | null> {
  try {
    await Purchases.invalidateCustomerInfoCache();
    const info = await Purchases.getCustomerInfo();
    console.log('[RC:CustomerInfo] All purchased product IDs:', info.allPurchasedProductIdentifiers);
    return info;
  } catch (error) {
    console.error('Failed to get customer info:', error);
    return null;
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
