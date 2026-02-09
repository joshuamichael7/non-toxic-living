import { useState, useCallback } from 'react';
import { View, Text, TextInput, ScrollView, Pressable, ActivityIndicator, Linking, Modal } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

import { searchCombined } from '@/services/api/analyze';
import type { CombinedSearchResult } from '@/services/api/analyze';
import { getFeaturedDeals, getDealsForSwapIds, trackClick, type FeaturedDeal } from '@/services/api/featured';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239, 68, 68, 0.15)',
  purple: '#8B5CF6',
  purpleGlow: 'rgba(139, 92, 246, 0.15)',
};

export default function SearchScreen() {
  const [searchQuery, setSearchQuery] = useState('');
  const [results, setResults] = useState<CombinedSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);
  const [selectedSwap, setSelectedSwap] = useState<CombinedSearchResult | null>(null);
  const [dealsResults, setDealsResults] = useState<FeaturedDeal[]>([]);
  const [showingDeals, setShowingDeals] = useState(false);
  const [dealMap, setDealMap] = useState<Map<string, { discount_text: string | null; badge_text: string | null; coupon_code: string | null }>>(new Map());
  const { t } = useTranslation();
  const router = useRouter();

  const handleSearch = useCallback(async (query: string, categories?: string[]) => {
    const trimmed = query.trim();
    if (!trimmed && !categories) return;
    setSearching(true);
    setHasSearched(true);
    setShowingDeals(false);
    setDealsResults([]);
    try {
      const data = await searchCombined(trimmed, 20, categories);
      setResults(data);
      // Fetch deal badges for swap results in parallel
      const swapIds = data.filter(r => r.source === 'swap').map(r => r.id);
      if (swapIds.length > 0) {
        getDealsForSwapIds(swapIds).then(setDealMap).catch(() => {});
      } else {
        setDealMap(new Map());
      }
    } catch {
      setResults([]);
    } finally {
      setSearching(false);
    }
  }, []);

  const handleDealsCategory = useCallback(async () => {
    setSearchQuery(t('coupon.deals'));
    setSearching(true);
    setHasSearched(true);
    setShowingDeals(true);
    setResults([]);
    try {
      const deals = await getFeaturedDeals(20);
      setDealsResults(deals);
    } catch {
      setDealsResults([]);
    } finally {
      setSearching(false);
    }
  }, [t]);

  const handleClear = () => {
    setSearchQuery('');
    setResults([]);
    setHasSearched(false);
  };

  const handleResultPress = (item: CombinedSearchResult) => {
    if (item.source === 'swap') {
      setSelectedSwap(item);
    } else {
      router.push(`/result/product-${item.id}`);
    }
  };

  const verdictConfig = {
    safe: { bg: 'rgba(16, 185, 129, 0.15)', color: '#10B981', borderColor: '#10B981' },
    caution: { bg: 'rgba(245, 158, 11, 0.15)', color: '#F59E0B', borderColor: '#F59E0B' },
    toxic: { bg: 'rgba(239, 68, 68, 0.15)', color: '#EF4444', borderColor: '#EF4444' },
  };

  const categories = [
    { name: t('coupon.deals'), icon: 'pricetag-outline' as const, dbCategories: ['__deals__'] as string[], isDeals: true },
    { name: t('category.foodDrinks'), icon: 'nutrition-outline' as const, dbCategories: ['food', 'snack', 'beverage', 'condiment', 'dairy'] },
    { name: t('category.personalCare'), icon: 'body-outline' as const, dbCategories: ['personal_care', 'soap', 'skincare', 'sunscreen', 'haircare', 'oral_care', 'deodorant', 'makeup', 'nail_care'] },
    { name: t('category.household'), icon: 'home-outline' as const, dbCategories: ['household', 'furniture', 'mattress', 'paint', 'garden', 'fragrance'] },
    { name: t('category.babyKids'), icon: 'happy-outline' as const, dbCategories: ['baby', 'baby_food', 'toys'] },
    { name: t('category.cookware'), icon: 'restaurant-outline' as const, dbCategories: ['cookware', 'storage'] },
    { name: t('category.cleaning'), icon: 'sparkles-outline' as const, dbCategories: ['cleaning', 'laundry'] },
  ];

  const popularSearches = [
    { label: t('search.nonToxicSunscreen'), dbCategories: ['sunscreen'] },
    { label: t('search.safeCookware'), dbCategories: ['cookware', 'storage'] },
    { label: t('search.cleanShampoo'), dbCategories: ['haircare'] },
    { label: t('search.organicSnacks'), dbCategories: ['snack', 'food'] },
    { label: t('search.pfasFree'), dbCategories: ['cookware', 'storage', 'clothing'] },
    { label: t('search.naturalDeodorant'), dbCategories: ['deodorant'] },
  ];

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }} edges={['top']}>
      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={{ paddingHorizontal: 24, paddingTop: 16, paddingBottom: 8 }}>
          <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>{t('search.title')}</Text>
          <Text style={{ color: colors.inkSecondary, marginTop: 4, fontSize: 15 }}>
            {t('search.subtitle')}
          </Text>
        </View>

        {/* Search Bar */}
        <View style={{ paddingHorizontal: 24, paddingVertical: 16 }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 16,
            flexDirection: 'row',
            alignItems: 'center',
            paddingHorizontal: 16,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04,
            shadowRadius: 12,
          }}>
            <Ionicons name="search" size={20} color={colors.inkMuted} />
            <TextInput
              style={{
                flex: 1,
                paddingVertical: 16,
                paddingHorizontal: 12,
                fontSize: 16,
                color: colors.ink,
              }}
              placeholder={t('search.placeholder')}
              placeholderTextColor={colors.inkMuted}
              value={searchQuery}
              onChangeText={setSearchQuery}
              onSubmitEditing={() => handleSearch(searchQuery)}
              returnKeyType="search"
            />
            {searchQuery.length > 0 && (
              <Pressable onPress={handleClear}>
                <Ionicons name="close-circle" size={20} color={colors.inkMuted} />
              </Pressable>
            )}
          </View>
        </View>

        {/* Search Results */}
        {searching ? (
          <View style={{ padding: 40, alignItems: 'center' }}>
            <ActivityIndicator size="large" color={colors.oxygen} />
            <Text style={{ color: colors.inkSecondary, marginTop: 12, fontSize: 14 }}>
              {t('search.searching')}
            </Text>
          </View>
        ) : hasSearched && showingDeals ? (
          /* Deals Results */
          dealsResults.length > 0 ? (
            <View style={{ paddingHorizontal: 24 }}>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('coupon.deals')} ({dealsResults.length})
              </Text>
              <View style={{ gap: 10 }}>
                {dealsResults.map((deal) => (
                  <Pressable
                    key={deal.id}
                    onPress={() => {
                      trackClick(deal.id);
                      if (deal.action_url) Linking.openURL(deal.action_url);
                    }}
                    style={{
                      backgroundColor: colors.glassSolid,
                      borderRadius: 20,
                      padding: 16,
                      flexDirection: 'row',
                      alignItems: 'center',
                      borderWidth: 1,
                      borderColor: colors.glassBorder,
                    }}
                  >
                    {/* Discount badge */}
                    <View style={{
                      width: 52,
                      height: 52,
                      borderRadius: 16,
                      backgroundColor: colors.purpleGlow,
                      alignItems: 'center',
                      justifyContent: 'center',
                      marginRight: 14,
                      borderWidth: 2,
                      borderColor: colors.purple,
                    }}>
                      <Ionicons name="pricetag" size={22} color={colors.purple} />
                    </View>
                    <View style={{ flex: 1 }}>
                      <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }} numberOfLines={1}>
                        {deal.title}
                      </Text>
                      <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, flexWrap: 'wrap' }}>
                        {deal.brand_name && (
                          <Text style={{ fontSize: 13, color: colors.inkSecondary }} numberOfLines={1}>
                            {deal.brand_name}
                          </Text>
                        )}
                        {deal.discount_text && (
                          <View style={{
                            backgroundColor: colors.purpleGlow,
                            borderRadius: 6,
                            paddingHorizontal: 6,
                            paddingVertical: 2,
                          }}>
                            <Text style={{ fontSize: 10, fontWeight: '700', color: colors.purple }}>{deal.discount_text}</Text>
                          </View>
                        )}
                        {deal.linked_swap && (
                          <View style={{
                            backgroundColor: colors.safeLight,
                            borderRadius: 6,
                            paddingHorizontal: 6,
                            paddingVertical: 2,
                            borderWidth: 1,
                            borderColor: colors.safe,
                          }}>
                            <Text style={{ fontSize: 10, fontWeight: '700', color: colors.safe }}>SAFE PICK</Text>
                          </View>
                        )}
                      </View>
                    </View>
                    <Ionicons name="chevron-forward" size={20} color={colors.inkMuted} />
                  </Pressable>
                ))}
              </View>
            </View>
          ) : (
            <View style={{ paddingHorizontal: 24, paddingTop: 40, alignItems: 'center' }}>
              <View style={{
                width: 80,
                height: 80,
                backgroundColor: colors.glassSolid,
                borderRadius: 24,
                alignItems: 'center',
                justifyContent: 'center',
                marginBottom: 20,
              }}>
                <Ionicons name="pricetag-outline" size={36} color={colors.inkMuted} />
              </View>
              <Text style={{ fontSize: 18, fontWeight: '600', color: colors.ink, textAlign: 'center', marginBottom: 8 }}>
                {t('deals.noneAvailable')}
              </Text>
            </View>
          )
        ) : hasSearched ? (
          results.length > 0 ? (
            <View style={{ paddingHorizontal: 24 }}>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('search.results')} ({results.length})
              </Text>
              <View style={{ gap: 10 }}>
                {results.map((item) => {
                  const verdict = (item.verdict || 'caution') as keyof typeof verdictConfig;
                  const vConfig = verdictConfig[verdict] || verdictConfig.caution;
                  const deal = item.source === 'swap' ? dealMap.get(item.id) : undefined;
                  return (
                    <Pressable
                      key={`${item.source}-${item.id}`}
                      onPress={() => handleResultPress(item)}
                      style={{
                        backgroundColor: colors.glassSolid,
                        borderRadius: 20,
                        padding: 16,
                        flexDirection: 'row',
                        alignItems: 'center',
                        borderWidth: 1,
                        borderColor: colors.glassBorder,
                      }}
                    >
                      <View style={{
                        width: 52,
                        height: 52,
                        borderRadius: 16,
                        backgroundColor: vConfig.bg,
                        alignItems: 'center',
                        justifyContent: 'center',
                        marginRight: 14,
                        borderWidth: 2,
                        borderColor: vConfig.borderColor,
                      }}>
                        <Text style={{ fontSize: 18, fontWeight: '800', color: vConfig.color }}>{item.score}</Text>
                      </View>
                      <View style={{ flex: 1 }}>
                        <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }} numberOfLines={1}>
                          {item.name}
                        </Text>
                        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, flexWrap: 'wrap' }}>
                          <Text style={{ fontSize: 13, color: colors.inkSecondary }} numberOfLines={1}>
                            {item.brand || ''}
                          </Text>
                          {item.source === 'swap' && (
                            <View style={{
                              backgroundColor: colors.safeLight,
                              borderRadius: 6,
                              paddingHorizontal: 6,
                              paddingVertical: 2,
                              borderWidth: 1,
                              borderColor: colors.safe,
                            }}>
                              <Text style={{ fontSize: 10, fontWeight: '700', color: colors.safe }}>SAFE PICK</Text>
                            </View>
                          )}
                          {deal && (
                            <View style={{
                              backgroundColor: colors.purpleGlow,
                              borderRadius: 6,
                              paddingHorizontal: 6,
                              paddingVertical: 2,
                            }}>
                              <Text style={{ fontSize: 10, fontWeight: '700', color: colors.purple }}>
                                {deal.discount_text || 'DEAL'}
                              </Text>
                            </View>
                          )}
                        </View>
                      </View>
                      <Ionicons name="chevron-forward" size={20} color={colors.inkMuted} />
                    </Pressable>
                  );
                })}
              </View>
            </View>
          ) : (
            <View style={{ paddingHorizontal: 24, paddingTop: 40, alignItems: 'center' }}>
              <View style={{
                width: 80,
                height: 80,
                backgroundColor: colors.glassSolid,
                borderRadius: 24,
                alignItems: 'center',
                justifyContent: 'center',
                marginBottom: 20,
              }}>
                <Ionicons name="search-outline" size={36} color={colors.inkMuted} />
              </View>
              <Text style={{ fontSize: 18, fontWeight: '600', color: colors.ink, textAlign: 'center', marginBottom: 8 }}>
                {t('search.noResults')}
              </Text>
              <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center' }}>
                {t('search.noResultsDesc')}
              </Text>
            </View>
          )
        ) : (
          <>
            {/* Categories */}
            <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('search.categories')}
              </Text>
              <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 12 }}>
                {categories.map((category, index) => (
                  <Pressable
                    key={category.name}
                    onPress={() => {
                      if ('isDeals' in category && category.isDeals) {
                        handleDealsCategory();
                      } else {
                        setSearchQuery(category.name);
                        handleSearch(category.name, category.dbCategories);
                      }
                    }}
                    style={{
                      backgroundColor: colors.glassSolid,
                      borderRadius: 20,
                      padding: 16,
                      alignItems: 'center',
                      width: '30%',
                      borderWidth: 1,
                      borderColor: colors.glassBorder,
                      shadowColor: '#000',
                      shadowOffset: { width: 0, height: 2 },
                      shadowOpacity: 0.04,
                      shadowRadius: 8,
                    }}
                  >
                    <View
                      style={{
                        width: 48,
                        height: 48,
                        borderRadius: 16,
                        alignItems: 'center',
                        justifyContent: 'center',
                        marginBottom: 8,
                        backgroundColor: index === 0 ? colors.oxygenGlow : colors.canvas,
                      }}
                    >
                      <Ionicons
                        name={category.icon}
                        size={24}
                        color={index === 0 ? colors.oxygen : colors.ink}
                      />
                    </View>
                    <Text style={{ fontSize: 12, fontWeight: '600', color: colors.ink, textAlign: 'center' }}>
                      {category.name}
                    </Text>
                  </Pressable>
                ))}
              </View>
            </View>

            {/* Popular Searches */}
            <View style={{ paddingHorizontal: 24 }}>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('search.popularSearches')}
              </Text>
              <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 10 }}>
                {popularSearches.map((search) => (
                  <Pressable
                    key={search.label}
                    style={{
                      backgroundColor: colors.glassSolid,
                      borderRadius: 12,
                      paddingHorizontal: 16,
                      paddingVertical: 10,
                      borderWidth: 1,
                      borderColor: colors.glassBorder,
                    }}
                    onPress={() => {
                      setSearchQuery(search.label);
                      handleSearch(search.label, search.dbCategories);
                    }}
                  >
                    <Text style={{ color: colors.ink, fontWeight: '500' }}>{search.label}</Text>
                  </Pressable>
                ))}
              </View>
            </View>
          </>
        )}
      </ScrollView>

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
