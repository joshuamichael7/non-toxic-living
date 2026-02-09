import { useState, useEffect } from 'react';
import { View, Text, Pressable, ScrollView, StyleSheet, ActivityIndicator, Alert } from 'react-native';
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
  type SubscriptionTier,
} from '@/services/purchases/RevenueCatService';

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
  white: '#FFFFFF',
};

interface TierConfig {
  id: SubscriptionTier;
  nameKey: string;
  descKey: string;
  features: string[];
  monthlyFallback: string;
  annualFallback: string;
  highlighted?: boolean;
}

const TIERS: TierConfig[] = [
  {
    id: 'free',
    nameKey: 'tier.free',
    descKey: 'tier.freeDesc',
    features: ['feature.freeScans', 'feature.basicAnalysis'],
    monthlyFallback: '$0',
    annualFallback: '$0',
  },
  {
    id: 'pro',
    nameKey: 'tier.pro',
    descKey: 'tier.proDesc',
    features: ['feature.proScans', 'feature.detailedReports', 'feature.prioritySupport'],
    monthlyFallback: '$7.99',
    annualFallback: '$87.99',
    highlighted: true,
  },
  {
    id: 'power',
    nameKey: 'tier.power',
    descKey: 'tier.powerDesc',
    features: ['feature.powerScans', 'feature.allProFeatures', 'feature.familySharing', 'feature.exportReports'],
    monthlyFallback: '$14.99',
    annualFallback: '$164.99',
  },
];

// Map tier+billing to RevenueCat package identifier
function getPackageId(tier: SubscriptionTier, isAnnual: boolean): string {
  if (tier === 'pro') return isAnnual ? '$rc_annual' : '$rc_monthly';
  if (tier === 'power') return isAnnual ? '$rc_annual' : '$rc_monthly';
  return '';
}

export default function SubscriptionScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const { tier: currentTier, setTier, refreshSubscription } = useSubscriptionStore();

  const [isAnnual, setIsAnnual] = useState(true);
  const [offering, setOffering] = useState<PurchasesOffering | null>(null);
  const [loading, setLoading] = useState(true);
  const [purchasing, setPurchasing] = useState<string | null>(null);
  const [restoring, setRestoring] = useState(false);

  useEffect(() => {
    loadOfferings();
  }, []);

  async function loadOfferings() {
    try {
      const currentOffering = await getOfferings();
      setOffering(currentOffering);
    } catch (error) {
      console.error('Failed to load offerings:', error);
    } finally {
      setLoading(false);
    }
  }

  function findPackage(tier: SubscriptionTier): PurchasesPackage | null {
    if (!offering) return null;

    // RevenueCat package identifiers
    const packages = offering.availablePackages;
    const productId = tier === 'pro'
      ? (isAnnual ? 'ntl_pro_annual' : 'ntl_pro_monthly')
      : (isAnnual ? 'ntl_power_annual' : 'ntl_power_monthly');

    return packages.find(p => p.product.identifier === productId) ?? null;
  }

  function getPrice(tier: TierConfig): string {
    if (tier.id === 'free') return t('price.free');

    const pkg = findPackage(tier.id);
    if (pkg) {
      return pkg.product.priceString;
    }

    // Fallback to hardcoded prices
    return isAnnual ? tier.annualFallback : tier.monthlyFallback;
  }

  function getPeriodLabel(tier: TierConfig): string {
    if (tier.id === 'free') return '';
    return isAnnual ? t('subscription.perYear') : t('subscription.perMonth');
  }

  async function handlePurchase(tier: SubscriptionTier) {
    const pkg = findPackage(tier);
    if (!pkg) {
      Alert.alert(t('common.error'), t('subscription.purchaseError'));
      return;
    }

    setPurchasing(tier);
    try {
      const customerInfo = await purchasePackage(pkg);
      if (customerInfo) {
        // Purchase succeeded
        await refreshSubscription();
        router.back();
      }
      // null = user cancelled, do nothing
    } catch (error) {
      console.error('Purchase error:', error);
      Alert.alert(t('common.error'), t('subscription.purchaseError'));
    } finally {
      setPurchasing(null);
    }
  }

  async function handleRestore() {
    setRestoring(true);
    try {
      await restorePurchases();
      await refreshSubscription();
      const newTier = useSubscriptionStore.getState().tier;
      if (newTier !== 'free') {
        Alert.alert(t('subscription.restored'));
        router.back();
      } else {
        Alert.alert(t('subscription.restoreNone'));
      }
    } catch (error) {
      console.error('Restore error:', error);
      Alert.alert(t('common.error'), t('subscription.purchaseError'));
    } finally {
      setRestoring(false);
    }
  }

  return (
    <SafeAreaView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Pressable onPress={() => router.back()} hitSlop={12}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={styles.headerTitle}>{t('subscription.title')}</Text>
        <View style={{ width: 28 }} />
      </View>

      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Subtitle */}
        <Text style={styles.subtitle}>{t('subscription.subtitle')}</Text>

        {/* Monthly / Annual Toggle */}
        <View style={styles.toggleContainer}>
          <Pressable
            onPress={() => setIsAnnual(false)}
            style={[styles.toggleButton, !isAnnual && styles.toggleButtonActive]}
          >
            <Text style={[styles.toggleText, !isAnnual && styles.toggleTextActive]}>
              {t('subscription.monthly')}
            </Text>
          </Pressable>
          <Pressable
            onPress={() => setIsAnnual(true)}
            style={[styles.toggleButton, isAnnual && styles.toggleButtonActive]}
          >
            <Text style={[styles.toggleText, isAnnual && styles.toggleTextActive]}>
              {t('subscription.annual')}
            </Text>
            {isAnnual && (
              <View style={styles.saveBadge}>
                <Text style={styles.saveBadgeText}>{t('subscription.oneMonthFree')}</Text>
              </View>
            )}
          </Pressable>
        </View>

        {/* Tier Cards */}
        {loading ? (
          <ActivityIndicator size="large" color={colors.oxygen} style={{ marginTop: 40 }} />
        ) : (
          TIERS.map((tier) => (
            <TierCard
              key={tier.id}
              tier={tier}
              currentTier={currentTier}
              price={getPrice(tier)}
              periodLabel={getPeriodLabel(tier)}
              isAnnual={isAnnual}
              purchasing={purchasing === tier.id}
              onPurchase={() => handlePurchase(tier.id)}
              t={t}
            />
          ))
        )}

        {/* Restore Purchases */}
        <Pressable
          onPress={handleRestore}
          disabled={restoring}
          style={styles.restoreButton}
        >
          {restoring ? (
            <ActivityIndicator size="small" color={colors.inkSecondary} />
          ) : (
            <Text style={styles.restoreText}>{t('subscription.restorePurchases')}</Text>
          )}
        </Pressable>

        {/* Cancel anytime + legal */}
        <Text style={styles.legalText}>{t('subscription.cancelAnytime')}</Text>
      </ScrollView>
    </SafeAreaView>
  );
}

function TierCard({
  tier,
  currentTier,
  price,
  periodLabel,
  isAnnual,
  purchasing,
  onPurchase,
  t,
}: {
  tier: TierConfig;
  currentTier: SubscriptionTier;
  price: string;
  periodLabel: string;
  isAnnual: boolean;
  purchasing: boolean;
  onPurchase: () => void;
  t: (key: string, options?: any) => string;
}) {
  const isCurrent = currentTier === tier.id;
  const isHighlighted = tier.highlighted;
  const isFree = tier.id === 'free';

  return (
    <View
      style={[
        styles.tierCard,
        isHighlighted && styles.tierCardHighlighted,
        isCurrent && styles.tierCardCurrent,
      ]}
    >
      {/* Header row */}
      <View style={styles.tierHeader}>
        <View style={{ flex: 1 }}>
          <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
            <Text style={[styles.tierName, isHighlighted && styles.tierNameHighlighted]}>
              {t(tier.nameKey)}
            </Text>
            {isHighlighted && (
              <View style={styles.popularBadge}>
                <Text style={styles.popularBadgeText}>{t('tier.proDesc')}</Text>
              </View>
            )}
            {isCurrent && (
              <View style={styles.currentBadge}>
                <Text style={styles.currentBadgeText}>{t('subscription.current')}</Text>
              </View>
            )}
          </View>
        </View>
        <View style={{ alignItems: 'flex-end' }}>
          <Text style={[styles.tierPrice, isHighlighted && styles.tierPriceHighlighted]}>
            {price}
          </Text>
          {periodLabel ? (
            <Text style={styles.tierPeriod}>{periodLabel}</Text>
          ) : null}
        </View>
      </View>

      {/* Features */}
      <View style={styles.featureList}>
        {tier.features.map((featureKey) => (
          <View key={featureKey} style={styles.featureRow}>
            <Ionicons
              name="checkmark-circle"
              size={18}
              color={isHighlighted ? colors.oxygen : colors.safe}
            />
            <Text style={styles.featureText}>{t(featureKey)}</Text>
          </View>
        ))}
      </View>

      {/* Action button */}
      {!isFree && !isCurrent && (
        <Pressable
          onPress={onPurchase}
          disabled={purchasing}
          style={[
            styles.subscribeButton,
            isHighlighted && styles.subscribeButtonHighlighted,
          ]}
        >
          {purchasing ? (
            <ActivityIndicator size="small" color={isHighlighted ? colors.white : colors.oxygen} />
          ) : (
            <Text style={[styles.subscribeButtonText, isHighlighted && styles.subscribeButtonTextHighlighted]}>
              {t('subscription.subscribe')}
            </Text>
          )}
        </Pressable>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.canvas,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: colors.ink,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: 20,
    paddingBottom: 100,
  },
  subtitle: {
    fontSize: 15,
    color: colors.inkSecondary,
    textAlign: 'center',
    marginBottom: 24,
    lineHeight: 22,
  },

  // Toggle
  toggleContainer: {
    flexDirection: 'row',
    backgroundColor: colors.glassSolid,
    borderRadius: 16,
    padding: 4,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: colors.glassBorder,
  },
  toggleButton: {
    flex: 1,
    paddingVertical: 12,
    borderRadius: 12,
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 6,
  },
  toggleButtonActive: {
    backgroundColor: colors.white,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.06,
    shadowRadius: 6,
  },
  toggleText: {
    fontSize: 15,
    fontWeight: '600',
    color: colors.inkMuted,
  },
  toggleTextActive: {
    color: colors.ink,
  },
  saveBadge: {
    backgroundColor: colors.safeLight,
    borderRadius: 8,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  saveBadgeText: {
    fontSize: 11,
    fontWeight: '700',
    color: colors.safe,
  },

  // Tier cards
  tierCard: {
    backgroundColor: colors.glassSolid,
    borderRadius: 24,
    padding: 20,
    marginBottom: 12,
    borderWidth: 1.5,
    borderColor: colors.glassBorder,
  },
  tierCardHighlighted: {
    borderColor: colors.oxygen,
    shadowColor: colors.oxygen,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
  },
  tierCardCurrent: {
    borderColor: colors.safe,
  },
  tierHeader: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    justifyContent: 'space-between',
    marginBottom: 16,
  },
  tierName: {
    fontSize: 20,
    fontWeight: '800',
    color: colors.ink,
  },
  tierNameHighlighted: {
    color: colors.oxygenDeep,
  },
  tierPrice: {
    fontSize: 24,
    fontWeight: '800',
    color: colors.ink,
  },
  tierPriceHighlighted: {
    color: colors.oxygenDeep,
  },
  tierPeriod: {
    fontSize: 13,
    color: colors.inkSecondary,
    marginTop: 2,
  },
  popularBadge: {
    backgroundColor: colors.oxygenGlow,
    borderRadius: 8,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  popularBadgeText: {
    fontSize: 11,
    fontWeight: '700',
    color: colors.oxygen,
  },
  currentBadge: {
    backgroundColor: colors.safeLight,
    borderRadius: 8,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  currentBadgeText: {
    fontSize: 11,
    fontWeight: '700',
    color: colors.safe,
  },

  // Features
  featureList: {
    gap: 10,
    marginBottom: 16,
  },
  featureRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  featureText: {
    fontSize: 14,
    color: colors.inkSecondary,
    fontWeight: '500',
  },

  // Subscribe button
  subscribeButton: {
    borderRadius: 16,
    paddingVertical: 14,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: colors.oxygen,
  },
  subscribeButtonHighlighted: {
    backgroundColor: colors.oxygen,
    borderColor: colors.oxygen,
    shadowColor: colors.oxygen,
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.3,
    shadowRadius: 12,
  },
  subscribeButtonText: {
    fontSize: 16,
    fontWeight: '700',
    color: colors.oxygen,
  },
  subscribeButtonTextHighlighted: {
    color: colors.white,
  },

  // Restore + legal
  restoreButton: {
    alignItems: 'center',
    paddingVertical: 16,
    marginTop: 8,
  },
  restoreText: {
    fontSize: 15,
    fontWeight: '600',
    color: colors.inkSecondary,
    textDecorationLine: 'underline',
  },
  legalText: {
    fontSize: 12,
    color: colors.inkMuted,
    textAlign: 'center',
    lineHeight: 18,
    paddingHorizontal: 20,
  },
});
