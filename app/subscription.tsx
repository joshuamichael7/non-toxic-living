import { useState, useEffect } from 'react';
import { View, Text, Pressable, ScrollView, StyleSheet, ActivityIndicator, Alert, Linking, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';
import type { PurchasesPackage, PurchasesOffering } from 'react-native-purchases';

import { useSubscriptionStore } from '@/stores/useSubscriptionStore';
import {
  getOfferings,
  purchasePackage,
  restorePurchases,
  getTierFromCustomerInfo,
  getBillingInfoFromCustomerInfo,
  type SubscriptionTier,
} from '@/services/purchases/RevenueCatService';
import { supabase } from '@/lib/supabase';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  oxygenDeep: '#0284C7',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.1)',
  amber: '#F59E0B',
  amberLight: 'rgba(245, 158, 11, 0.1)',
  white: '#FFFFFF',
};

interface TierConfig {
  id: SubscriptionTier;
  nameKey: string;
  features: string[];
  monthlyFallback: string;
  annualFallback: string;
  highlighted?: boolean;
}

const TIERS: TierConfig[] = [
  {
    id: 'free',
    nameKey: 'tier.free',
    features: ['feature.freeScans', 'feature.basicAnalysis'],
    monthlyFallback: '$0',
    annualFallback: '$0',
  },
  {
    id: 'pro',
    nameKey: 'tier.pro',
    features: ['feature.proScans', 'feature.detailedReports'],
    monthlyFallback: '$7.99',
    annualFallback: '$87.99',
    highlighted: true,
  },
  {
    id: 'power',
    nameKey: 'tier.power',
    features: ['feature.powerScans', 'feature.allProFeatures'],
    monthlyFallback: '$14.99',
    annualFallback: '$164.99',
  },
];

// Map plan ID like 'pro_monthly' to a display name like 'Pro Monthly'
function planIdToLabel(planId: string, t: (key: string) => string): string {
  if (planId === 'free') return t('tier.free');
  const [tier, period] = planId.split('_');
  const tierName = t(`tier.${tier}`);
  const periodName = period === 'annual' ? t('subscription.billingAnnual') : t('subscription.billingMonthly');
  return `${tierName} ${periodName}`;
}

// Build the plan ID for a card based on tier + current tab
function cardPlanId(tierId: SubscriptionTier, isAnnual: boolean): string {
  if (tierId === 'free') return 'free';
  return `${tierId}_${isAnnual ? 'annual' : 'monthly'}`;
}

function formatDate(isoDate: string): string {
  return new Date(isoDate).toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' });
}

function openStoreSettings() {
  if (Platform.OS === 'ios') {
    Linking.openURL('https://apps.apple.com/account/subscriptions');
  } else {
    Linking.openURL('https://play.google.com/store/account/subscriptions');
  }
}

export default function SubscriptionScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const {
    tier: currentTier,
    billingPeriod: currentBillingPeriod,
    willRenew,
    expirationDate,
    activePlanId,
    pendingPlanId,
    pendingEffectiveDate,
    refreshSubscription,
  } = useSubscriptionStore();

  const [isAnnual, setIsAnnual] = useState(false);
  const [offering, setOffering] = useState<PurchasesOffering | null>(null);
  const [loading, setLoading] = useState(true);
  const [purchasing, setPurchasing] = useState<string | null>(null);
  const [restoring, setRestoring] = useState(false);
  useEffect(() => {
    loadOfferings();
    refreshSubscription();
  }, []);

  async function loadOfferings() {
    try {
      setOffering(await getOfferings());
    } catch (error) {
      console.error('Failed to load offerings:', error);
    } finally {
      setLoading(false);
    }
  }

  function findPackage(tier: SubscriptionTier, annual: boolean): PurchasesPackage | null {
    if (!offering) return null;
    const productId = tier === 'pro'
      ? (annual ? 'ntl_pro_annual' : 'ntl_pro_monthly')
      : (annual ? 'ntl_power_annual' : 'ntl_power_monthly');
    return offering.availablePackages.find(p => p.product.identifier === productId) ?? null;
  }

  function getPrice(tier: TierConfig): string {
    if (tier.id === 'free') return t('price.free');
    const pkg = findPackage(tier.id, isAnnual);
    return pkg ? pkg.product.priceString : (isAnnual ? tier.annualFallback : tier.monthlyFallback);
  }

  function getPeriodLabel(tier: TierConfig): string {
    if (tier.id === 'free') return '';
    return isAnnual ? t('subscription.perYear') : t('subscription.perMonth');
  }

  async function handlePurchase(tier: SubscriptionTier) {
    const pkg = findPackage(tier, isAnnual);
    if (!pkg) {
      Alert.alert(t('common.error'), t('subscription.purchaseError'));
      return;
    }

    const purchasedPlanId = pkg.product.identifier.replace('ntl_', ''); // e.g. 'pro_monthly'
    const planBefore = useSubscriptionStore.getState().activePlanId;

    setPurchasing(tier);
    try {
      // 1. Make the purchase — returns CustomerInfo with current active state
      const customerInfo = await purchasePackage(pkg);
      if (!customerInfo) return; // User cancelled

      // 2. Check if the active plan actually changed (upgrade = immediate, downgrade = deferred)
      const newTier = getTierFromCustomerInfo(customerInfo);
      const newBilling = getBillingInfoFromCustomerInfo(customerInfo);
      const newPlanId = newTier === 'free' ? 'free' : `${newTier}_${newBilling.billingPeriod || 'monthly'}`;

      const isDeferred = newPlanId === planBefore && purchasedPlanId !== planBefore;

      if (isDeferred) {
        // Deferred downgrade: active plan didn't change, but Apple accepted the switch.
        // Write pending to DB FIRST so refreshSubscription picks it up.
        const { data: { user } } = await supabase.auth.getUser();
        if (user) {
          await (supabase as any)
            .from('profiles')
            .update({
              pending_subscription: purchasedPlanId,
              pending_subscription_effective_at: newBilling.expirationDate,
            })
            .eq('id', user.id);
        }
      }

      // 3. Now refresh — DB already has pending if it was a downgrade
      await refreshSubscription();

      // 4. Tell the user what happened
      if (isDeferred) {
        const pendingLabel = planIdToLabel(purchasedPlanId, t);
        const currentLabel = planIdToLabel(planBefore, t);
        const dateStr = newBilling.expirationDate ? formatDate(newBilling.expirationDate) : '';
        Alert.alert(
          t('subscription.changeScheduled'),
          t('subscription.changeScheduledDesc', { newPlan: pendingLabel, currentPlan: currentLabel, date: dateStr }),
        );
      }
    } catch (error: any) {
      await refreshSubscription();
      if (!error.userCancelled) {
        console.error('Purchase error:', error);
        Alert.alert(t('common.error'), t('subscription.purchaseError'));
      }
    } finally {
      setPurchasing(null);
    }
  }

  function handleSwitchToFree() {
    Alert.alert(
      t('subscription.downgradeTitle'),
      t('subscription.downgradeMessage'),
      [{ text: 'OK' }]
    );
  }

  async function handleRestore() {
    setRestoring(true);
    try {
      await restorePurchases();
      await refreshSubscription();
      const newTier = useSubscriptionStore.getState().tier;
      Alert.alert(newTier !== 'free' ? t('subscription.restored') : t('subscription.restoreNone'));
    } catch (error) {
      console.error('Restore error:', error);
      Alert.alert(t('common.error'), t('subscription.purchaseError'));
    } finally {
      setRestoring(false);
    }
  }

  const visibleTiers = isAnnual ? TIERS.filter((tier): tier is TierConfig => tier.id !== 'free') : TIERS;

  const currentPlanLabel = currentTier === 'free'
    ? t('tier.free')
    : `${t(`tier.${currentTier}`)} ${currentBillingPeriod === 'annual' ? t('subscription.billingAnnual') : t('subscription.billingMonthly')}`;

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Pressable onPress={() => router.back()} hitSlop={12}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={styles.headerTitle}>{t('subscription.title')}</Text>
        <View style={{ width: 28 }} />
      </View>

      <ScrollView style={styles.scrollView} contentContainerStyle={styles.scrollContent} showsVerticalScrollIndicator={false}>
        {/* Current plan status */}
        {currentTier !== 'free' && (
          <View style={styles.statusBanner}>
            <View style={styles.statusRow}>
              <Ionicons name="checkmark-circle" size={18} color={colors.safe} />
              <Text style={styles.statusText}>{currentPlanLabel}</Text>
            </View>
            {expirationDate && (
              <Text style={styles.statusDetail}>
                {willRenew
                  ? t('subscription.renewsOn', { date: formatDate(expirationDate) })
                  : t('subscription.endsOn', { date: formatDate(expirationDate) })}
              </Text>
            )}
            {/* Show pending change info */}
            {pendingPlanId && pendingPlanId !== activePlanId && (
              <View style={styles.pendingRow}>
                <Ionicons name="swap-horizontal" size={16} color={colors.amber} />
                <Text style={styles.pendingText}>
                  {t('subscription.switchingTo', {
                    plan: planIdToLabel(pendingPlanId, t),
                    date: pendingEffectiveDate ? formatDate(pendingEffectiveDate) : '',
                  })}
                </Text>
              </View>
            )}
            {/* Only show App Store link when subscription is expiring (not renewing) */}
            {!willRenew && (
              <Pressable onPress={openStoreSettings} style={styles.manageLink}>
                <Text style={styles.manageLinkText}>{t('subscription.manageInStore')}</Text>
                <Ionicons name="open-outline" size={14} color={colors.oxygen} />
              </Pressable>
            )}
          </View>
        )}

        <Text style={styles.subtitle}>{t('subscription.subtitle')}</Text>

        {/* Monthly / Annual Toggle */}
        <View style={styles.toggleContainer}>
          <Pressable onPress={() => setIsAnnual(false)} style={[styles.toggleButton, !isAnnual && styles.toggleButtonActive]}>
            <Text style={[styles.toggleText, !isAnnual && styles.toggleTextActive]}>{t('subscription.monthly')}</Text>
          </Pressable>
          <Pressable onPress={() => setIsAnnual(true)} style={[styles.toggleButton, isAnnual && styles.toggleButtonActive]}>
            <Text style={[styles.toggleText, isAnnual && styles.toggleTextActive]}>{t('subscription.annual')}</Text>
            {isAnnual && (
              <View style={styles.saveBadge}>
                <Text style={styles.saveBadgeText}>{t('subscription.oneMonthFree')}</Text>
              </View>
            )}
          </Pressable>
        </View>

        {/* Plan cards */}
        {loading ? (
          <ActivityIndicator size="large" color={colors.oxygen} style={{ marginTop: 40 }} />
        ) : (
          visibleTiers.map((tier) => {
            const thisPlanId = cardPlanId(tier.id, isAnnual);
            const isCurrent = thisPlanId === activePlanId;
            const isPending = pendingPlanId === thisPlanId && !isCurrent;

            const periodName = isAnnual ? t('subscription.billingAnnual') : t('subscription.billingMonthly');
            const buttonLabel = tier.id === 'free'
              ? t('subscription.switchToFree')
              : t('subscription.switchTo', { plan: `${t(tier.nameKey)} ${periodName}` });

            return (
              <TierCard
                key={tier.id}
                tier={tier}
                isCurrent={isCurrent}
                isPending={isPending}
                hasPendingChange={!!pendingPlanId && pendingPlanId !== activePlanId}
                price={getPrice(tier)}
                periodLabel={getPeriodLabel(tier)}
                buttonLabel={buttonLabel}
                purchasing={purchasing === tier.id}
                onAction={() => tier.id === 'free' ? handleSwitchToFree() : handlePurchase(tier.id)}
                onCancelPending={async () => {
                  await useSubscriptionStore.getState().cancelPendingChange();
                  await refreshSubscription();
                }}
                t={t}
              />
            );
          })
        )}

        <Pressable onPress={handleRestore} disabled={restoring} style={styles.restoreButton}>
          {restoring ? (
            <ActivityIndicator size="small" color={colors.inkSecondary} />
          ) : (
            <Text style={styles.restoreText}>{t('subscription.restorePurchases')}</Text>
          )}
        </Pressable>

        <Text style={styles.legalText}>{t('subscription.cancelAnytime')}</Text>
      </ScrollView>
    </SafeAreaView>
  );
}

function TierCard({ tier, isCurrent, isPending, hasPendingChange, price, periodLabel, buttonLabel, purchasing, onAction, onCancelPending, t }: {
  tier: TierConfig; isCurrent: boolean; isPending: boolean; hasPendingChange: boolean;
  price: string; periodLabel: string; buttonLabel: string; purchasing: boolean;
  onAction: () => void; onCancelPending: () => void;
  t: (key: string, options?: any) => string;
}) {
  const isHighlighted = tier.highlighted && !isCurrent && !isPending;

  return (
    <View style={[
      styles.tierCard,
      isHighlighted && styles.tierCardHighlighted,
      isCurrent && styles.tierCardCurrent,
      isPending && styles.tierCardPending,
    ]}>
      <View style={styles.tierHeader}>
        <View style={{ flex: 1 }}>
          <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
            <Text style={[styles.tierName, isHighlighted && styles.tierNameHighlighted]}>{t(tier.nameKey)}</Text>
            {isHighlighted && (
              <View style={styles.popularBadge}><Text style={styles.popularBadgeText}>{t('tier.proDesc')}</Text></View>
            )}
            {isCurrent && (
              <View style={styles.currentBadge}><Text style={styles.currentBadgeText}>{t('subscription.current')}</Text></View>
            )}
            {isPending && (
              <View style={styles.scheduledBadge}><Text style={styles.scheduledBadgeText}>{t('subscription.scheduled')}</Text></View>
            )}
          </View>
        </View>
        <View style={{ alignItems: 'flex-end' }}>
          <Text style={[styles.tierPrice, isHighlighted && styles.tierPriceHighlighted]}>{price}</Text>
          {periodLabel ? <Text style={styles.tierPeriod}>{periodLabel}</Text> : null}
        </View>
      </View>

      <View style={styles.featureList}>
        {tier.features.map((featureKey) => (
          <View key={featureKey} style={styles.featureRow}>
            <Ionicons name="checkmark-circle" size={18} color={isHighlighted ? colors.oxygen : colors.safe} />
            <Text style={styles.featureText}>{t(featureKey)}</Text>
          </View>
        ))}
      </View>

      {/* Current plan with pending change: show "Keep Current Plan" to cancel the pending */}
      {isCurrent && hasPendingChange && (
        <Pressable onPress={onCancelPending} style={[styles.subscribeButton, styles.keepCurrentButton]}>
          <Text style={[styles.subscribeButtonText, styles.keepCurrentText]}>{t('subscription.keepCurrent')}</Text>
        </Pressable>
      )}

      {/* Non-current, non-pending: show switch button */}
      {!isCurrent && !isPending && (
        <Pressable
          onPress={onAction}
          disabled={purchasing}
          style={[styles.subscribeButton, isHighlighted && styles.subscribeButtonHighlighted, tier.id === 'free' && styles.subscribeButtonMuted]}
        >
          {purchasing ? (
            <ActivityIndicator size="small" color={isHighlighted ? colors.white : colors.oxygen} />
          ) : (
            <Text style={[styles.subscribeButtonText, isHighlighted && styles.subscribeButtonTextHighlighted, tier.id === 'free' && styles.subscribeButtonTextMuted]}>
              {buttonLabel}
            </Text>
          )}
        </Pressable>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: colors.canvas },
  header: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingHorizontal: 20, paddingVertical: 16 },
  headerTitle: { fontSize: 18, fontWeight: '700', color: colors.ink },
  scrollView: { flex: 1 },
  scrollContent: { paddingHorizontal: 20, paddingBottom: 100 },

  statusBanner: { backgroundColor: colors.safeLight, borderRadius: 16, padding: 16, marginBottom: 16, borderWidth: 1, borderColor: 'rgba(16, 185, 129, 0.2)' },
  statusRow: { flexDirection: 'row', alignItems: 'center', gap: 8 },
  statusText: { fontSize: 15, fontWeight: '700', color: colors.ink },
  statusDetail: { fontSize: 13, color: colors.inkSecondary, marginTop: 4, marginLeft: 26 },
  pendingRow: { flexDirection: 'row', alignItems: 'center', gap: 6, marginTop: 8, marginLeft: 26 },
  pendingText: { fontSize: 13, fontWeight: '600', color: colors.amber, flex: 1 },
  manageLink: { flexDirection: 'row', alignItems: 'center', gap: 4, marginTop: 8, marginLeft: 26 },
  manageLinkText: { fontSize: 13, fontWeight: '600', color: colors.oxygen },

  subtitle: { fontSize: 15, color: colors.inkSecondary, textAlign: 'center', marginBottom: 24, lineHeight: 22 },

  toggleContainer: { flexDirection: 'row', backgroundColor: colors.glassSolid, borderRadius: 16, padding: 4, marginBottom: 24, borderWidth: 1, borderColor: colors.glassBorder },
  toggleButton: { flex: 1, paddingVertical: 12, borderRadius: 12, alignItems: 'center', flexDirection: 'row', justifyContent: 'center', gap: 6 },
  toggleButtonActive: { backgroundColor: colors.white, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.06, shadowRadius: 6 },
  toggleText: { fontSize: 15, fontWeight: '600', color: colors.inkMuted },
  toggleTextActive: { color: colors.ink },
  saveBadge: { backgroundColor: colors.safeLight, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 3 },
  saveBadgeText: { fontSize: 11, fontWeight: '700', color: colors.safe },

  tierCard: { backgroundColor: colors.glassSolid, borderRadius: 24, padding: 20, marginBottom: 12, borderWidth: 1.5, borderColor: colors.glassBorder },
  tierCardHighlighted: { borderColor: colors.oxygen, shadowColor: colors.oxygen, shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.15, shadowRadius: 12 },
  tierCardCurrent: { borderColor: colors.safe },
  tierCardPending: { borderColor: colors.amber },
  tierHeader: { flexDirection: 'row', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 16 },
  tierName: { fontSize: 20, fontWeight: '800', color: colors.ink },
  tierNameHighlighted: { color: colors.oxygenDeep },
  tierPrice: { fontSize: 24, fontWeight: '800', color: colors.ink },
  tierPriceHighlighted: { color: colors.oxygenDeep },
  tierPeriod: { fontSize: 13, color: colors.inkSecondary, marginTop: 2 },
  popularBadge: { backgroundColor: colors.oxygenGlow, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 3 },
  popularBadgeText: { fontSize: 11, fontWeight: '700', color: colors.oxygen },
  currentBadge: { backgroundColor: colors.safeLight, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 3 },
  currentBadgeText: { fontSize: 11, fontWeight: '700', color: colors.safe },
  scheduledBadge: { backgroundColor: colors.amberLight, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 3 },
  scheduledBadgeText: { fontSize: 11, fontWeight: '700', color: colors.amber },

  featureList: { gap: 10, marginBottom: 16 },
  featureRow: { flexDirection: 'row', alignItems: 'center', gap: 10 },
  featureText: { fontSize: 14, color: colors.inkSecondary, fontWeight: '500' },

  subscribeButton: { borderRadius: 16, paddingVertical: 14, alignItems: 'center', borderWidth: 2, borderColor: colors.oxygen },
  subscribeButtonHighlighted: { backgroundColor: colors.oxygen, borderColor: colors.oxygen, shadowColor: colors.oxygen, shadowOffset: { width: 0, height: 6 }, shadowOpacity: 0.3, shadowRadius: 12 },
  subscribeButtonMuted: { borderColor: colors.inkMuted },
  keepCurrentButton: { borderColor: colors.safe, backgroundColor: colors.safeLight },
  keepCurrentText: { color: colors.safe },
  subscribeButtonText: { fontSize: 16, fontWeight: '700', color: colors.oxygen },
  subscribeButtonTextHighlighted: { color: colors.white },
  subscribeButtonTextMuted: { color: colors.inkSecondary },

  restoreButton: { alignItems: 'center', paddingVertical: 16, marginTop: 8 },
  restoreText: { fontSize: 15, fontWeight: '600', color: colors.inkSecondary, textDecorationLine: 'underline' },
  legalText: { fontSize: 12, color: colors.inkMuted, textAlign: 'center', lineHeight: 18, paddingHorizontal: 20 },
});
