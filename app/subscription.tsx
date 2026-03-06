import { useState, useEffect } from 'react';
import { View, Text, Pressable, ScrollView, ActivityIndicator, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';
import type { PurchasesPackage, PurchasesOffering } from 'react-native-purchases';

import { useCreditStore } from '@/stores/useSubscriptionStore';
import {
  getCreditOfferings,
  purchaseCreditPack,
  restorePurchases,
} from '@/services/purchases/RevenueCatService';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenDeep: '#0284C7',
  oxygenGlow: 'rgba(14, 165, 233, 0.12)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeDeep: '#059669',
  safeLight: 'rgba(16, 185, 129, 0.12)',
  white: '#FFFFFF',
};

interface PackConfig {
  productKey: string;
  credits: number;
  accentColor: string;
  accentDeep: string;
  accentGlow: string;
  badge?: string;
  features: string[];
}

const PACKS: PackConfig[] = [
  {
    productKey: 'ntl_credits_200',
    credits: 200,
    accentColor: colors.oxygen,
    accentDeep: colors.oxygenDeep,
    accentGlow: colors.oxygenGlow,
    features: [
      '200 scans, no expiry',
      'Full ingredient analysis',
      'Safe swap recommendations',
    ],
  },
  {
    productKey: 'ntl_credits_500',
    credits: 500,
    accentColor: colors.safe,
    accentDeep: colors.safeDeep,
    accentGlow: colors.safeLight,
    badge: 'Best Value',
    features: [
      '500 scans, no expiry',
      'Full ingredient analysis',
      'Safe swap recommendations',
    ],
  },
];

export default function CreditsScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const { credits, refreshCredits } = useCreditStore();

  const [offering, setOffering] = useState<PurchasesOffering | null>(null);
  const [purchasing, setPurchasing] = useState<string | null>(null);
  const [isRestoring, setIsRestoring] = useState(false);
  const [loadingOffering, setLoadingOffering] = useState(true);

  useEffect(() => {
    getCreditOfferings().then((o) => {
      setOffering(o);
      setLoadingOffering(false);
    });
  }, []);

  const findPackage = (productKey: string): PurchasesPackage | null => {
    if (!offering) return null;
    return offering.availablePackages.find(
      (pkg) => pkg.product.identifier.includes(productKey)
    ) ?? null;
  };

  const handlePurchase = async (pack: PackConfig) => {
    const pkg = findPackage(pack.productKey);
    if (!pkg) {
      Alert.alert('Not Available', 'This pack is not available right now. Please try again later.');
      return;
    }

    setPurchasing(pack.productKey);
    try {
      const creditsAdded = await purchaseCreditPack(pkg);
      if (creditsAdded !== null) {
        await refreshCredits();
        Alert.alert(
          '✓ Credits Added',
          `${creditsAdded} scan credits have been added to your account.`,
          [{ text: 'Great!', onPress: () => router.back() }]
        );
      }
    } catch (error: any) {
      Alert.alert('Purchase Failed', error?.message || 'Something went wrong. Please try again.');
    } finally {
      setPurchasing(null);
    }
  };

  const handleRestore = async () => {
    setIsRestoring(true);
    try {
      await restorePurchases();
      await refreshCredits();
      Alert.alert('Restored', 'Your purchases have been restored.');
    } catch (error: any) {
      Alert.alert('Restore Failed', error?.message || 'Could not restore purchases.');
    } finally {
      setIsRestoring(false);
    }
  };

  const isOnTrial = credits === 10;

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      <ScrollView
        contentContainerStyle={{ paddingHorizontal: 24, paddingBottom: 48 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={{ flexDirection: 'row', alignItems: 'center', paddingTop: 16, marginBottom: 28 }}>
          <Pressable onPress={() => router.back()} style={{ marginRight: 16, padding: 4 }} hitSlop={8}>
            <Ionicons name="chevron-back" size={24} color={colors.ink} />
          </Pressable>
          <Text style={{ fontSize: 22, fontWeight: '800', color: colors.ink, flex: 1 }}>
            {t('credits.title')}
          </Text>
        </View>

        {/* Current balance card */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 24,
          padding: 24,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          alignItems: 'center',
          marginBottom: 10,
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.05,
          shadowRadius: 12,
        }}>
          <View style={{
            width: 64,
            height: 64,
            borderRadius: 32,
            backgroundColor: colors.oxygenGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 14,
          }}>
            <Ionicons name="scan-outline" size={30} color={colors.oxygen} />
          </View>
          <Text style={{ fontSize: 48, fontWeight: '900', color: colors.ink, lineHeight: 54 }}>
            {credits}
          </Text>
          <Text style={{ fontSize: 15, color: colors.inkSecondary, marginTop: 4 }}>
            scans remaining
          </Text>
          <Text style={{ fontSize: 12, color: colors.inkMuted, marginTop: 4 }}>
            1 credit = 1 scan
          </Text>

          {isOnTrial && (
            <View style={{
              marginTop: 14,
              backgroundColor: colors.safeLight,
              borderRadius: 10,
              paddingHorizontal: 14,
              paddingVertical: 8,
            }}>
              <Text style={{ color: colors.safe, fontWeight: '600', fontSize: 13, textAlign: 'center' }}>
                {t('credits.trialBanner')}
              </Text>
            </View>
          )}
        </View>

        {/* Never expire note */}
        <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', marginBottom: 28, gap: 5 }}>
          <Ionicons name="infinite-outline" size={14} color={colors.safe} />
          <Text style={{ fontSize: 13, color: colors.safe, fontWeight: '600' }}>
            {t('credits.neverExpire')}
          </Text>
        </View>

        {/* Pack cards */}
        {loadingOffering ? (
          <ActivityIndicator color={colors.oxygen} style={{ marginVertical: 32 }} />
        ) : (
          PACKS.map((pack) => {
            const pkg = findPackage(pack.productKey);
            const isPurchasing = purchasing === pack.productKey;
            const isDisabled = !!purchasing || isRestoring;

            return (
              <View
                key={pack.productKey}
                style={{
                  backgroundColor: colors.glassSolid,
                  borderRadius: 24,
                  marginBottom: 16,
                  borderWidth: 1.5,
                  borderColor: pack.badge ? pack.accentColor : colors.glassBorder,
                  shadowColor: pack.badge ? pack.accentColor : '#000',
                  shadowOffset: { width: 0, height: pack.badge ? 8 : 4 },
                  shadowOpacity: pack.badge ? 0.2 : 0.05,
                  shadowRadius: pack.badge ? 16 : 10,
                  overflow: 'hidden',
                }}
              >
                {/* Colored header band */}
                <View style={{
                  backgroundColor: pack.accentColor,
                  paddingHorizontal: 20,
                  paddingTop: 18,
                  paddingBottom: 20,
                }}>
                  <View style={{ flexDirection: 'row', alignItems: 'flex-start', justifyContent: 'space-between' }}>
                    <View>
                      <Text style={{ fontSize: 28, fontWeight: '900', color: colors.white, lineHeight: 32 }}>
                        {pack.credits} Scans
                      </Text>
                    </View>
                    <View style={{ alignItems: 'flex-end', gap: 6 }}>
                      {pack.badge && (
                        <View style={{
                          backgroundColor: 'rgba(255,255,255,0.25)',
                          borderRadius: 10,
                          paddingHorizontal: 10,
                          paddingVertical: 4,
                        }}>
                          <Text style={{ fontSize: 11, fontWeight: '800', color: colors.white, letterSpacing: 0.5 }}>
                            {pack.badge.toUpperCase()}
                          </Text>
                        </View>
                      )}
                      <Text style={{ fontSize: 32, fontWeight: '900', color: colors.white }}>
                        {pkg?.product.priceString ?? '—'}
                      </Text>
                    </View>
                  </View>
                </View>

                {/* Features + CTA */}
                <View style={{ paddingHorizontal: 20, paddingTop: 16, paddingBottom: 20 }}>
                  <View style={{ gap: 10, marginBottom: 18 }}>
                    {pack.features.map((feature) => (
                      <View key={feature} style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
                        <View style={{
                          width: 22,
                          height: 22,
                          borderRadius: 11,
                          backgroundColor: pack.accentGlow,
                          alignItems: 'center',
                          justifyContent: 'center',
                        }}>
                          <Ionicons name="checkmark" size={13} color={pack.accentColor} />
                        </View>
                        <Text style={{ fontSize: 14, color: colors.inkSecondary, fontWeight: '500' }}>
                          {feature}
                        </Text>
                      </View>
                    ))}
                  </View>

                  <Pressable
                    onPress={() => handlePurchase(pack)}
                    disabled={isDisabled}
                    style={{ opacity: isDisabled && !isPurchasing ? 0.5 : 1 }}
                  >
                    {({ pressed }) => (
                      <View style={{
                        backgroundColor: pressed ? pack.accentDeep : pack.accentColor,
                        borderRadius: 16,
                        paddingVertical: 16,
                        alignItems: 'center',
                        justifyContent: 'center',
                        shadowColor: pack.accentColor,
                        shadowOffset: { width: 0, height: 6 },
                        shadowOpacity: 0.4,
                        shadowRadius: 12,
                        elevation: 6,
                      }}>
                        {isPurchasing ? (
                          <ActivityIndicator color={colors.white} />
                        ) : (
                          <Text style={{ fontSize: 17, fontWeight: '800', color: colors.white, letterSpacing: 0.3 }}>
                            Get {pack.credits} Scans · {pkg?.product.priceString ?? '—'}
                          </Text>
                        )}
                      </View>
                    )}
                  </Pressable>
                </View>
              </View>
            );
          })
        )}

        {/* Restore purchases */}
        <Pressable
          onPress={handleRestore}
          disabled={isRestoring || !!purchasing}
          style={{ alignItems: 'center', marginTop: 4, paddingVertical: 12 }}
        >
          {isRestoring ? (
            <ActivityIndicator color={colors.inkMuted} />
          ) : (
            <Text style={{ color: colors.inkMuted, fontSize: 14, fontWeight: '500' }}>
              {t('credits.restore')}
            </Text>
          )}
        </Pressable>
      </ScrollView>
    </SafeAreaView>
  );
}
