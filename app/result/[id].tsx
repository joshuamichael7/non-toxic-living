import { useState, useEffect } from 'react';
import { View, Text, ScrollView, Pressable, Share, ActivityIndicator, Linking, Modal } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Haptics from 'expo-haptics';

import { useScanStore } from '@/stores/useScanStore';
import { useAuthStore } from '@/stores/useAuthStore';
import { StorePrompt } from '@/components/swaps/StorePrompt';
import { getScanById, saveScanToList, getSwapsForProduct, getProductById } from '@/services/api/analyze';
import { CouponCard } from '@/components/swaps/CouponCard';
import { getDealsForProduct, type FeaturedDeal } from '@/services/api/featured';
import { FeaturedCard } from '@/components/home/FeaturedCard';
import type { AnalysisResult, Concern, Swap } from '@/services/api/analyze';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenDeep: '#0284C7',
  oxygenLight: '#38BDF8',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239, 68, 68, 0.15)',
};

// Demo data for when accessed directly (e.g., /result/demo)
const DEMO_RESULT = {
  productName: 'Cheetos Crunchy',
  brand: 'Frito-Lay',
  category: 'food',
  score: 34,
  verdict: 'caution' as const,
  summary: 'Contains several artificial additives and highly processed ingredients that may have negative health effects.',
  dadsTake: "I keep these out of my house. The artificial colors and MSG derivatives aren't worth it when there are better options that taste just as good.",
  concerns: [
    { ingredient: 'Yellow 6', severity: 'medium' as const, description: 'Artificial color linked to hyperactivity in children', category: 'color' },
    { ingredient: 'Red 40', severity: 'medium' as const, description: 'Synthetic dye with potential carcinogenic properties', category: 'color' },
    { ingredient: 'MSG', severity: 'low' as const, description: 'Flavor enhancer that may cause sensitivity reactions', category: 'additive' },
  ],
  positives: ['No trans fats', 'Gluten-free'],
  swaps: [
    { id: '1', name: 'Lesser Evil Paleo Puffs', brand: 'Lesser Evil', score: 82, affiliate_url: undefined },
    { id: '2', name: 'Hippeas Organic Chickpea Puffs', brand: 'Hippeas', score: 78, affiliate_url: undefined },
  ],
  ocrSource: 'device' as const,
  model: 'gpt-4o-mini',
  cached: false,
  cachedAt: undefined,
  coupons: [],
};

const severityConfig = {
  low: { bg: colors.glassSolid, color: colors.inkSecondary, borderColor: colors.glassBorder },
  medium: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution },
  high: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic },
};

export default function ResultScreen() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const { currentResult, clearScan } = useScanStore();
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);

  const verdictConfig = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe, label: t('verdict.safe'), icon: 'checkmark-circle' as const },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution, label: t('verdict.caution'), icon: 'alert-circle' as const },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic, label: t('verdict.toxic'), icon: 'close-circle' as const },
  };

  const [saved, setSaved] = useState(false);
  const [dbResult, setDbResult] = useState<AnalysisResult | null>(null);
  const [loading, setLoading] = useState(false);
  const [scanId, setScanId] = useState<string | null>(null);
  const [selectedSwap, setSelectedSwap] = useState<Swap | null>(null);
  const [sessionStore, setSessionStore] = useState<string | null>(null);
  const [filteredSwaps, setFilteredSwaps] = useState<Swap[] | null>(null);
  const [loadingSwaps, setLoadingSwaps] = useState(false);
  const [deals, setDeals] = useState<FeaturedDeal[]>([]);

  // Load scan from DB when viewing a past scan, or product from products table
  useEffect(() => {
    if (id === 'scan' || id === 'demo') return;
    const idStr = id as string;
    setLoading(true);

    // Handle product-{uuid} prefix from search results
    if (idStr.startsWith('product-')) {
      const productId = idStr.replace('product-', '');
      getProductById(productId)
        .then(async (product) => {
          if (product) {
            // Try to fetch swaps for this product's category
            let swaps: any[] = [];
            if (product.score < 67) {
              try {
                swaps = await getSwapsForProduct(productId);
              } catch {}
            }
            setDbResult({ ...product, swaps });
          }
        })
        .catch(() => setDbResult(null))
        .finally(() => setLoading(false));
      return;
    }

    getScanById(idStr)
      .then(async (scan) => {
        setScanId(scan.id);
        setSaved(scan.saved_to_list === 'favorites');
        const analysis = scan.analysis as { concerns?: Concern[]; positives?: string[]; swaps?: any[]; dadsTake?: string; summary?: string } | null;

        // If swaps aren't saved in analysis JSON, fetch them from DB
        let swaps = analysis?.swaps || [];
        if (swaps.length === 0 && scan.product_id && scan.score < 67) {
          try {
            swaps = await getSwapsForProduct(scan.product_id);
          } catch {}
        }

        setDbResult({
          productName: scan.product_name,
          brand: scan.brand || '',
          category: '',
          score: scan.score,
          verdict: scan.verdict,
          summary: analysis?.summary || scan.product_name,
          dadsTake: analysis?.dadsTake || '',
          concerns: analysis?.concerns || [],
          positives: analysis?.positives || [],
          swaps,
          ocrSource: scan.ocr_source || 'device',
          model: scan.ai_model_used || 'cached',
          cached: scan.was_cached,
        });
      })
      .catch(() => {
        // Fall back to demo if scan not found
        setDbResult(null);
      })
      .finally(() => setLoading(false));
  }, [id]);

  // For fresh scans, track the scan ID for saving
  useEffect(() => {
    if (id === 'scan' && currentResult) {
      // The scan was just created - scanId comes from the store or we skip DB save
      setScanId(null);
    }
  }, [id, currentResult]);

  // Fetch deals for this product
  useEffect(() => {
    const source = id === 'scan' && currentResult ? currentResult : id === 'demo' ? DEMO_RESULT : dbResult;
    if (!source) return;

    const idStr = id as string;
    const productId = idStr.startsWith('product-') ? idStr.replace('product-', '') : '';
    const category = source.category || '';

    if (productId || category) {
      getDealsForProduct(productId, category).then(setDeals).catch(() => {});
    }
  }, [id, dbResult, currentResult]);

  // Re-fetch swaps when session store changes
  useEffect(() => {
    if (sessionStore === null) {
      setFilteredSwaps(null);
      return;
    }

    const source = id === 'scan' && currentResult ? currentResult : dbResult;
    if (!source) return;

    // Need a product ID to query swaps — get it from the URL or scan
    const idStr = id as string;
    let productId: string | null = null;
    if (idStr.startsWith('product-')) {
      productId = idStr.replace('product-', '');
    } else if (idStr !== 'scan' && idStr !== 'demo') {
      // It's a scan ID — we may have product_id from the scan
      productId = scanId; // scanId is the scan row, but we need product_id
    }

    // For fresh scans and DB results with swaps, try filtering client-side first
    if (source.swaps && source.swaps.length > 0) {
      const storeFiltered = source.swaps.filter(
        (s) => s.available_stores && s.available_stores.some(
          (st) => st.toLowerCase() === sessionStore.toLowerCase()
        )
      );
      if (storeFiltered.length > 0) {
        setFilteredSwaps(storeFiltered);
        return;
      }
    }

    // Client-side filter found nothing, try server query if we have a product ID
    if (productId) {
      setLoadingSwaps(true);
      getSwapsForProduct(productId, sessionStore)
        .then((swaps) => setFilteredSwaps(swaps))
        .catch(() => setFilteredSwaps(null))
        .finally(() => setLoadingSwaps(false));
    } else {
      // No product ID — just show unfiltered (store filter had no matches)
      setFilteredSwaps(null);
    }
  }, [sessionStore]);

  // Determine result source
  const result = id === 'scan' && currentResult
    ? currentResult
    : dbResult || DEMO_RESULT;
  const config = verdictConfig[result.verdict];

  if (loading) {
    return (
      <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas, alignItems: 'center', justifyContent: 'center' }}>
        <ActivityIndicator size="large" color={colors.oxygen} />
        <Text style={{ color: colors.inkSecondary, marginTop: 12, fontSize: 14 }}>{t('common.loading')}</Text>
      </SafeAreaView>
    );
  }

  const handleClose = () => {
    clearScan();
    router.back();
  };

  const handleScanAgain = () => {
    clearScan();
    router.replace('/(tabs)/scan');
  };

  const handleShare = async () => {
    const verdictLabel = result.verdict === 'safe' ? 'Safe' : result.verdict === 'caution' ? 'Caution' : 'Avoid';
    const concernList = result.concerns.length > 0
      ? `\nConcerns: ${result.concerns.map(c => c.ingredient).join(', ')}`
      : '';
    const message = `${result.productName} by ${result.brand} - Score: ${result.score}/100 (${verdictLabel})${concernList}\n\nScanned with Non-Toxic Living`;
    try {
      await Share.share({ message });
    } catch {}
  };

  const handleSave = async () => {
    const newSaved = !saved;
    setSaved(newSaved);
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);

    // Persist to DB if we have a scan ID
    const idToSave = scanId || (id !== 'scan' && id !== 'demo' ? id as string : null);
    if (idToSave) {
      try {
        await saveScanToList(idToSave, newSaved ? 'favorites' : null);
      } catch {
        // Revert on error
        setSaved(!newSaved);
      }
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }} edges={['top']}>
      {/* Header */}
      <View style={{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 20,
        paddingVertical: 12,
      }}>
        <Pressable
          style={{
            width: 44,
            height: 44,
            borderRadius: 14,
            backgroundColor: colors.glassSolid,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            alignItems: 'center',
            justifyContent: 'center'
          }}
          onPress={handleClose}
        >
          <Ionicons name="close" size={24} color={colors.ink} />
        </Pressable>
        <Text style={{ fontSize: 14, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>{t('result.title')}</Text>
        <Pressable
          onPress={handleShare}
          style={{
            width: 44,
            height: 44,
            borderRadius: 14,
            backgroundColor: colors.glassSolid,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            alignItems: 'center',
            justifyContent: 'center'
          }}
        >
          <Ionicons name="share-outline" size={22} color={colors.ink} />
        </Pressable>
      </View>

      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingBottom: 120 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Cached Result Badge */}
        {result.cached && (
          <View style={{
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            marginHorizontal: 20,
            marginBottom: 12,
          }}>
            <View style={{
              flexDirection: 'row',
              alignItems: 'center',
              backgroundColor: colors.oxygenGlow,
              borderRadius: 12,
              paddingVertical: 8,
              paddingHorizontal: 14,
              borderWidth: 1,
              borderColor: colors.oxygen,
            }}>
              <Ionicons name="flash" size={16} color={colors.oxygen} style={{ marginRight: 6 }} />
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.oxygen }}>
                {t('result.cached')}
              </Text>
            </View>
          </View>
        )}

        {/* Score Hero - Glass with colored accent */}
        <View style={{
          backgroundColor: colors.glassSolid,
          marginHorizontal: 20,
          borderRadius: 32,
          padding: 28,
          alignItems: 'center',
          marginBottom: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 8 },
          shadowOpacity: 0.06,
          shadowRadius: 24,
        }}>
          {/* Score Ring */}
          <View style={{
            width: 120,
            height: 120,
            borderRadius: 40,
            backgroundColor: config.bg,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 20,
            borderWidth: 4,
            borderColor: config.borderColor,
            shadowColor: config.color,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}>
            <Text style={{ fontSize: 48, fontWeight: '800', color: config.color }}>{result.score}</Text>
          </View>
          <Text style={{ fontSize: 24, fontWeight: '800', color: colors.ink, textAlign: 'center', marginBottom: 4 }}>
            {result.productName}
          </Text>
          <Text style={{ fontSize: 14, color: colors.inkSecondary, marginBottom: 16, fontWeight: '500' }}>{result.brand}</Text>
          <View style={{
            flexDirection: 'row',
            alignItems: 'center',
            backgroundColor: config.bg,
            borderRadius: 12,
            paddingVertical: 8,
            paddingHorizontal: 16,
            borderWidth: 1,
            borderColor: config.borderColor,
          }}>
            <Ionicons name={config.icon} size={18} color={config.color} style={{ marginRight: 6 }} />
            <Text style={{ fontSize: 14, fontWeight: '700', color: config.color }}>
              {config.label}
            </Text>
          </View>
        </View>

        {/* Summary - Glass card */}
        <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            padding: 20,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04,
            shadowRadius: 12,
          }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
              <View style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                backgroundColor: colors.oxygenGlow,
                alignItems: 'center',
                justifyContent: 'center',
                marginRight: 10,
              }}>
                <Ionicons name="document-text" size={16} color={colors.oxygen} />
              </View>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.3, textTransform: 'uppercase' }}>{t('result.summary')}</Text>
            </View>
            <Text style={{ fontSize: 15, color: colors.ink, lineHeight: 24, fontWeight: '500' }}>{result.summary}</Text>
          </View>
        </View>

        {/* Our Take - Accent card with oxygen glow */}
        <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
          <View style={{
            backgroundColor: colors.oxygen,
            borderRadius: 24,
            padding: 20,
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
              <View style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                backgroundColor: 'rgba(255, 255, 255, 0.2)',
                alignItems: 'center',
                justifyContent: 'center',
                marginRight: 10,
              }}>
                <Ionicons name="chatbubble" size={16} color="white" />
              </View>
              <Text style={{ fontSize: 13, fontWeight: '700', color: 'white', letterSpacing: 0.3, textTransform: 'uppercase' }}>{t('result.expertTake')}</Text>
            </View>
            <Text style={{ fontSize: 15, color: 'white', lineHeight: 24, fontWeight: '500' }}>
              "{result.dadsTake}"
            </Text>
          </View>
        </View>

        {/* Concerns */}
        {result.concerns && result.concerns.length > 0 && (
          <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('result.concerns', { count: result.concerns.length })}
            </Text>
            <View style={{ gap: 10 }}>
              {result.concerns.map((concern, index) => {
                const sConfig = severityConfig[concern.severity];
                return (
                  <View
                    key={`${concern.ingredient}-${index}`}
                    style={{
                      backgroundColor: colors.glassSolid,
                      borderRadius: 20,
                      padding: 16,
                      borderWidth: 1,
                      borderColor: colors.glassBorder,
                      shadowColor: '#000',
                      shadowOffset: { width: 0, height: 2 },
                      shadowOpacity: 0.04,
                      shadowRadius: 8,
                    }}
                  >
                    <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', marginBottom: 8, gap: 8 }}>
                      <Text style={{ fontSize: 15, fontWeight: '700', color: colors.ink, flexShrink: 1 }} numberOfLines={2}>
                        {concern.ingredient}
                      </Text>
                      <View style={{
                        backgroundColor: sConfig.bg,
                        borderRadius: 8,
                        paddingVertical: 4,
                        paddingHorizontal: 10,
                        borderWidth: 1,
                        borderColor: sConfig.borderColor,
                        flexShrink: 0,
                      }}>
                        <Text style={{ fontSize: 11, fontWeight: '600', color: sConfig.color, textTransform: 'capitalize' }}>
                          {concern.severity}
                        </Text>
                      </View>
                    </View>
                    <Text style={{ fontSize: 14, color: colors.inkSecondary, lineHeight: 20 }}>{concern.description}</Text>
                  </View>
                );
              })}
            </View>
          </View>
        )}

        {/* Positives */}
        {result.positives && result.positives.length > 0 && (
          <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('result.positives')}
            </Text>
            <View style={{ gap: 8 }}>
              {result.positives.map((positive) => (
                <View key={positive} style={{
                  backgroundColor: colors.safeLight,
                  borderRadius: 12,
                  paddingVertical: 10,
                  paddingHorizontal: 14,
                  flexDirection: 'row',
                  alignItems: 'center',
                  borderWidth: 1,
                  borderColor: colors.safe,
                }}>
                  <Ionicons name="checkmark-circle" size={16} color={colors.safe} style={{ marginRight: 6, flexShrink: 0 }} />
                  <Text style={{ fontSize: 14, fontWeight: '600', color: colors.safe, flexShrink: 1 }}>{positive}</Text>
                </View>
              ))}
            </View>
          </View>
        )}

        {/* Deals & Discounts */}
        {deals.length > 0 && (
          <View style={{ marginBottom: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, paddingHorizontal: 20, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('coupon.deals')}
            </Text>
            <ScrollView
              horizontal
              showsHorizontalScrollIndicator={false}
              contentContainerStyle={{ paddingHorizontal: 20, gap: 12 }}
            >
              {deals.map((deal) => (
                <FeaturedCard key={deal.id} item={deal} />
              ))}
            </ScrollView>
          </View>
        )}

        {/* Better Alternatives */}
        {result.swaps && result.swaps.length > 0 && (
          <View style={{ paddingHorizontal: 20 }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('result.betterAlternatives')}
              </Text>
              {!sessionStore && (
                <Pressable
                  onPress={() => setSessionStore('')}
                  style={{
                    flexDirection: 'row',
                    alignItems: 'center',
                    backgroundColor: colors.oxygenGlow,
                    borderRadius: 10,
                    paddingVertical: 6,
                    paddingHorizontal: 10,
                  }}
                >
                  <Ionicons name="storefront-outline" size={14} color={colors.oxygen} style={{ marginRight: 4 }} />
                  <Text style={{ fontSize: 12, fontWeight: '600', color: colors.oxygen }}>
                    {t('store.findAtStore')}
                  </Text>
                </Pressable>
              )}
            </View>

            {/* Store filter (shown when user taps "Find at a store") */}
            {sessionStore !== null && (
              <View style={{ marginBottom: 12, marginHorizontal: -20 }}>
                <StorePrompt
                  currentStore={sessionStore || null}
                  onStoreSet={(store) => setSessionStore(store)}
                  onStoreClear={() => setSessionStore(null)}
                />
              </View>
            )}

            {loadingSwaps && (
              <ActivityIndicator size="small" color={colors.oxygen} style={{ marginBottom: 12 }} />
            )}

            <View style={{ gap: 10 }}>
              {(filteredSwaps || result.swaps).map((swap) => (
                <Pressable
                  key={swap.id}
                  onPress={() => setSelectedSwap(swap)}
                  style={{
                    backgroundColor: colors.glassSolid,
                    borderRadius: 20,
                    padding: 16,
                    flexDirection: 'row',
                    alignItems: 'center',
                    borderWidth: 1,
                    borderColor: colors.glassBorder,
                    shadowColor: '#000',
                    shadowOffset: { width: 0, height: 2 },
                    shadowOpacity: 0.04,
                    shadowRadius: 8,
                  }}
                >
                  <View style={{
                    width: 52,
                    height: 52,
                    borderRadius: 16,
                    backgroundColor: colors.safeLight,
                    alignItems: 'center',
                    justifyContent: 'center',
                    marginRight: 14,
                    borderWidth: 2,
                    borderColor: colors.safe,
                  }}>
                    <Text style={{ fontSize: 18, fontWeight: '800', color: colors.safe }}>{swap.score}</Text>
                  </View>
                  <View style={{ flex: 1 }}>
                    <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }}>{swap.name}</Text>
                    <Text style={{ fontSize: 13, color: colors.inkSecondary }}>{swap.brand}</Text>
                  </View>
                  <View style={{
                    width: 36,
                    height: 36,
                    borderRadius: 12,
                    backgroundColor: colors.oxygenGlow,
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}>
                    <Ionicons name="arrow-forward" size={18} color={colors.oxygen} />
                  </View>
                </Pressable>
              ))}
            </View>
          </View>
        )}

        {/* Coupons / Partner Deals */}
        {result.coupons && result.coupons.length > 0 && (
          <View style={{ paddingHorizontal: 20, marginTop: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('coupon.deals')}
            </Text>
            <View style={{ gap: 12 }}>
              {result.coupons.map((coupon) => (
                <CouponCard key={coupon.id} coupon={coupon} />
              ))}
            </View>
          </View>
        )}

      </ScrollView>

      {/* Bottom Actions */}
      <View style={{
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        backgroundColor: colors.glassSolid,
        paddingHorizontal: 20,
        paddingTop: 16,
        paddingBottom: 34,
        borderTopWidth: 1,
        borderTopColor: colors.glassBorder,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: -4 },
        shadowOpacity: 0.04,
        shadowRadius: 12,
      }}>
        <View style={{ flexDirection: 'row', gap: 12 }}>
          <Pressable
            onPress={handleSave}
            style={{
              flex: 1,
              backgroundColor: saved ? colors.safeLight : colors.canvas,
              borderRadius: 16,
              paddingVertical: 16,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              borderWidth: 1,
              borderColor: saved ? colors.safe : colors.glassBorder,
            }}
          >
            <Ionicons name={saved ? 'heart' : 'heart-outline'} size={20} color={saved ? colors.safe : colors.ink} />
            <Text style={{ fontSize: 16, fontWeight: '600', color: saved ? colors.safe : colors.ink, marginLeft: 8 }}>
              {saved ? t('result.saved') : t('result.save')}
            </Text>
          </Pressable>
          <Pressable
            style={{
              flex: 1,
              backgroundColor: colors.oxygen,
              borderRadius: 16,
              paddingVertical: 16,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 8 },
              shadowOpacity: 0.3,
              shadowRadius: 16,
            }}
            onPress={handleScanAgain}
          >
            <Ionicons name="scan-outline" size={20} color="white" />
            <Text style={{ fontSize: 16, fontWeight: '700', color: 'white', marginLeft: 8 }}>{t('result.scanAgain')}</Text>
          </Pressable>
        </View>
      </View>
      {/* Swap Detail Modal */}
      <Modal
        visible={!!selectedSwap}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={() => setSelectedSwap(null)}
      >
        {selectedSwap && (
          <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
            {/* Modal Header */}
            <View style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'space-between',
              paddingHorizontal: 20,
              paddingVertical: 16,
              borderBottomWidth: 1,
              borderBottomColor: colors.glassBorder,
            }}>
              <Pressable
                onPress={() => setSelectedSwap(null)}
                style={{
                  width: 44,
                  height: 44,
                  borderRadius: 14,
                  backgroundColor: colors.glassSolid,
                  borderWidth: 1,
                  borderColor: colors.glassBorder,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <Ionicons name="close" size={24} color={colors.ink} />
              </Pressable>
              <Text style={{ fontSize: 14, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('result.betterAlternatives')}
              </Text>
              <View style={{ width: 44 }} />
            </View>

            <ScrollView
              style={{ flex: 1 }}
              contentContainerStyle={{ padding: 20, paddingBottom: 120 }}
              showsVerticalScrollIndicator={false}
            >
              {/* Score Hero */}
              <View style={{
                backgroundColor: colors.glassSolid,
                borderRadius: 32,
                padding: 28,
                alignItems: 'center',
                marginBottom: 20,
                borderWidth: 1,
                borderColor: colors.glassBorder,
                shadowColor: '#000',
                shadowOffset: { width: 0, height: 8 },
                shadowOpacity: 0.06,
                shadowRadius: 24,
              }}>
                <View style={{
                  width: 100,
                  height: 100,
                  borderRadius: 34,
                  backgroundColor: colors.safeLight,
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: 20,
                  borderWidth: 4,
                  borderColor: colors.safe,
                  shadowColor: colors.safe,
                  shadowOffset: { width: 0, height: 8 },
                  shadowOpacity: 0.3,
                  shadowRadius: 16,
                }}>
                  <Text style={{ fontSize: 40, fontWeight: '800', color: colors.safe }}>{selectedSwap.score}</Text>
                </View>
                <Text style={{ fontSize: 22, fontWeight: '800', color: colors.ink, textAlign: 'center', marginBottom: 4 }}>
                  {selectedSwap.name}
                </Text>
                <Text style={{ fontSize: 14, color: colors.inkSecondary, fontWeight: '500', marginBottom: 12 }}>
                  {selectedSwap.brand}
                </Text>
                <View style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  backgroundColor: colors.safeLight,
                  borderRadius: 12,
                  paddingVertical: 8,
                  paddingHorizontal: 16,
                  borderWidth: 1,
                  borderColor: colors.safe,
                }}>
                  <Ionicons name="checkmark-circle" size={18} color={colors.safe} style={{ marginRight: 6 }} />
                  <Text style={{ fontSize: 14, fontWeight: '700', color: colors.safe }}>
                    {t('swap.safetyScore')}: {selectedSwap.score}/100
                  </Text>
                </View>
              </View>

              {/* Why Better */}
              {selectedSwap.why_better && (
                <View style={{
                  backgroundColor: colors.glassSolid,
                  borderRadius: 24,
                  padding: 20,
                  marginBottom: 20,
                  borderWidth: 1,
                  borderColor: colors.glassBorder,
                }}>
                  <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
                    <View style={{
                      width: 32,
                      height: 32,
                      borderRadius: 10,
                      backgroundColor: colors.safeLight,
                      alignItems: 'center',
                      justifyContent: 'center',
                      marginRight: 10,
                    }}>
                      <Ionicons name="leaf" size={16} color={colors.safe} />
                    </View>
                    <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.3, textTransform: 'uppercase' }}>
                      {t('swap.whyBetter')}
                    </Text>
                  </View>
                  <Text style={{ fontSize: 15, color: colors.ink, lineHeight: 24, fontWeight: '500' }}>
                    {selectedSwap.why_better}
                  </Text>
                </View>
              )}

              {/* Available Stores */}
              {selectedSwap.available_stores && selectedSwap.available_stores.length > 0 && (
                <View style={{
                  backgroundColor: colors.glassSolid,
                  borderRadius: 24,
                  padding: 20,
                  marginBottom: 20,
                  borderWidth: 1,
                  borderColor: colors.glassBorder,
                }}>
                  <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
                    <View style={{
                      width: 32,
                      height: 32,
                      borderRadius: 10,
                      backgroundColor: colors.oxygenGlow,
                      alignItems: 'center',
                      justifyContent: 'center',
                      marginRight: 10,
                    }}>
                      <Ionicons name="storefront" size={16} color={colors.oxygen} />
                    </View>
                    <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.3, textTransform: 'uppercase' }}>
                      {t('swap.availableAt')}
                    </Text>
                  </View>
                  <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 8 }}>
                    {selectedSwap.available_stores.map((store) => (
                      <View key={store} style={{
                        backgroundColor: colors.canvas,
                        borderRadius: 12,
                        paddingVertical: 8,
                        paddingHorizontal: 14,
                        borderWidth: 1,
                        borderColor: colors.glassBorder,
                      }}>
                        <Text style={{ fontSize: 14, fontWeight: '500', color: colors.ink }}>{store}</Text>
                      </View>
                    ))}
                  </View>
                </View>
              )}

              {/* Badges */}
              {selectedSwap.badges && selectedSwap.badges.length > 0 && (
                <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 8, marginBottom: 20 }}>
                  {selectedSwap.badges.map((badge) => (
                    <View key={badge} style={{
                      backgroundColor: colors.safeLight,
                      borderRadius: 12,
                      paddingVertical: 8,
                      paddingHorizontal: 14,
                      borderWidth: 1,
                      borderColor: colors.safe,
                      flexDirection: 'row',
                      alignItems: 'center',
                    }}>
                      <Ionicons name="ribbon" size={14} color={colors.safe} style={{ marginRight: 6 }} />
                      <Text style={{ fontSize: 13, fontWeight: '600', color: colors.safe }}>{badge}</Text>
                    </View>
                  ))}
                </View>
              )}
            </ScrollView>

            {/* Bottom CTA */}
            <View style={{
              position: 'absolute',
              bottom: 0,
              left: 0,
              right: 0,
              backgroundColor: colors.glassSolid,
              paddingHorizontal: 20,
              paddingTop: 16,
              paddingBottom: 34,
              borderTopWidth: 1,
              borderTopColor: colors.glassBorder,
            }}>
              {selectedSwap.affiliate_url ? (
                <Pressable
                  onPress={() => {
                    if (selectedSwap.affiliate_url) {
                      Linking.openURL(selectedSwap.affiliate_url);
                    }
                  }}
                  style={{
                    backgroundColor: colors.safe,
                    borderRadius: 16,
                    paddingVertical: 18,
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'center',
                    shadowColor: colors.safe,
                    shadowOffset: { width: 0, height: 8 },
                    shadowOpacity: 0.3,
                    shadowRadius: 16,
                  }}
                >
                  <Ionicons name="cart" size={22} color="white" style={{ marginRight: 10 }} />
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 18 }}>
                    {t('swap.shopNow')}
                  </Text>
                </Pressable>
              ) : (
                <Pressable
                  onPress={() => setSelectedSwap(null)}
                  style={{
                    backgroundColor: colors.oxygen,
                    borderRadius: 16,
                    paddingVertical: 18,
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 18 }}>
                    {t('swap.close')}
                  </Text>
                </Pressable>
              )}
            </View>
          </SafeAreaView>
        )}
      </Modal>
    </SafeAreaView>
  );
}

