import { useState, useEffect, useMemo } from 'react';
import { View, Text, ScrollView, Pressable, ActivityIndicator } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { getFeaturedDeals, type FeaturedDeal } from '@/services/api/featured';
import { SwapDealBanner } from '@/components/swaps/SwapDealBanner';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  purple: '#8B5CF6',
  purpleBg: 'rgba(139, 92, 246, 0.1)',
  purpleBorder: 'rgba(139, 92, 246, 0.3)',
  oxygen: '#0EA5E9',
};

const CATEGORY_LABELS: Record<string, string> = {
  food: 'Food',
  beverages: 'Beverages',
  personal_care: 'Personal Care',
  cleaning: 'Cleaning',
  home: 'Home',
  baby: 'Baby',
  cookware: 'Cookware',
  supplements: 'Supplements',
};

export default function DealsScreen() {
  const { t } = useTranslation();
  const [deals, setDeals] = useState<FeaturedDeal[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

  useEffect(() => {
    getFeaturedDeals(50).then((data) => {
      setDeals(data);
      setLoading(false);
    });
  }, []);

  // Extract unique categories from deals' linked swaps
  const categories = useMemo(() => {
    const cats = new Set<string>();
    for (const deal of deals) {
      const cat = deal.linked_swap?.category;
      if (cat) cats.add(cat);
    }
    return Array.from(cats).sort();
  }, [deals]);

  // Filter deals by selected category
  const filteredDeals = useMemo(() => {
    if (!selectedCategory) return deals;
    return deals.filter((d) => d.linked_swap?.category === selectedCategory);
  }, [deals, selectedCategory]);

  const howItWorksSteps = [
    { icon: 'search-outline' as const, title: t('deals.howStep1Title'), desc: t('deals.howStep1Desc') },
    { icon: 'copy-outline' as const, title: t('deals.howStep2Title'), desc: t('deals.howStep2Desc') },
    { icon: 'wallet-outline' as const, title: t('deals.howStep3Title'), desc: t('deals.howStep3Desc') },
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
          <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>
            {t('deals.title')}
          </Text>
          <Text style={{ fontSize: 15, color: colors.inkSecondary, marginTop: 4 }}>
            {t('deals.subtitle')}
          </Text>
        </View>

        {/* Savings Value Prop Banner */}
        <View style={{ paddingHorizontal: 24, marginTop: 16, marginBottom: 20 }}>
          <View style={{
            backgroundColor: colors.purpleBg,
            borderRadius: 20,
            padding: 20,
            borderWidth: 1,
            borderColor: colors.purpleBorder,
            flexDirection: 'row',
            alignItems: 'center',
          }}>
            <View style={{
              width: 44,
              height: 44,
              borderRadius: 14,
              backgroundColor: colors.purple,
              alignItems: 'center',
              justifyContent: 'center',
              marginRight: 14,
            }}>
              <Ionicons name="trending-down" size={24} color="white" />
            </View>
            <View style={{ flex: 1 }}>
              <Text style={{ fontSize: 14, fontWeight: '700', color: colors.purple, marginBottom: 2 }}>
                {t('deals.savingsValueProp')}
              </Text>
            </View>
          </View>
        </View>

        {/* How It Works */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <Text style={{
            fontSize: 13,
            fontWeight: '600',
            color: colors.inkSecondary,
            marginBottom: 14,
            letterSpacing: 0.5,
            textTransform: 'uppercase',
          }}>
            {t('deals.howItWorks')}
          </Text>
          <View style={{ flexDirection: 'row', gap: 10 }}>
            {howItWorksSteps.map((step, index) => (
              <View
                key={index}
                style={{
                  flex: 1,
                  backgroundColor: colors.glassSolid,
                  borderRadius: 16,
                  padding: 14,
                  borderWidth: 1,
                  borderColor: colors.glassBorder,
                  alignItems: 'center',
                }}
              >
                <View style={{
                  width: 36,
                  height: 36,
                  borderRadius: 12,
                  backgroundColor: colors.purpleBg,
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: 8,
                }}>
                  <Ionicons name={step.icon} size={18} color={colors.purple} />
                </View>
                <Text style={{
                  fontSize: 12,
                  fontWeight: '700',
                  color: colors.ink,
                  textAlign: 'center',
                  marginBottom: 4,
                }}>
                  {step.title}
                </Text>
                <Text style={{
                  fontSize: 11,
                  color: colors.inkSecondary,
                  textAlign: 'center',
                  lineHeight: 15,
                }}>
                  {step.desc}
                </Text>
              </View>
            ))}
          </View>
        </View>

        {/* Category Filter Pills */}
        {categories.length > 0 && (
          <View style={{ marginBottom: 16 }}>
            <ScrollView
              horizontal
              showsHorizontalScrollIndicator={false}
              contentContainerStyle={{ paddingHorizontal: 24, gap: 8 }}
            >
              <Pressable
                onPress={() => setSelectedCategory(null)}
                style={{
                  backgroundColor: !selectedCategory ? colors.purple : colors.glassSolid,
                  borderRadius: 12,
                  paddingVertical: 8,
                  paddingHorizontal: 14,
                  borderWidth: 1,
                  borderColor: !selectedCategory ? colors.purple : colors.glassBorder,
                }}
              >
                <Text style={{
                  fontSize: 13,
                  fontWeight: '600',
                  color: !selectedCategory ? 'white' : colors.ink,
                }}>
                  {t('deals.filterAll')}
                </Text>
              </Pressable>
              {categories.map((cat) => (
                <Pressable
                  key={cat}
                  onPress={() => setSelectedCategory(cat === selectedCategory ? null : cat)}
                  style={{
                    backgroundColor: selectedCategory === cat ? colors.purple : colors.glassSolid,
                    borderRadius: 12,
                    paddingVertical: 8,
                    paddingHorizontal: 14,
                    borderWidth: 1,
                    borderColor: selectedCategory === cat ? colors.purple : colors.glassBorder,
                  }}
                >
                  <Text style={{
                    fontSize: 13,
                    fontWeight: '600',
                    color: selectedCategory === cat ? 'white' : colors.ink,
                  }}>
                    {CATEGORY_LABELS[cat] || cat.replace(/_/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase())}
                  </Text>
                </Pressable>
              ))}
            </ScrollView>
          </View>
        )}

        {/* All Deals Header */}
        <View style={{ paddingHorizontal: 24, marginBottom: 14 }}>
          <Text style={{
            fontSize: 13,
            fontWeight: '600',
            color: colors.inkSecondary,
            letterSpacing: 0.5,
            textTransform: 'uppercase',
          }}>
            {t('deals.allDeals')}
          </Text>
        </View>

        {/* Deal List */}
        <View style={{ paddingHorizontal: 24 }}>
          {loading ? (
            <View style={{ paddingVertical: 40, alignItems: 'center' }}>
              <ActivityIndicator size="large" color={colors.purple} />
            </View>
          ) : filteredDeals.length > 0 ? (
            <SwapDealBanner deals={filteredDeals} />
          ) : (
            /* Empty State */
            <View style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 24,
              padding: 32,
              alignItems: 'center',
              borderWidth: 1,
              borderColor: colors.glassBorder,
            }}>
              <View style={{
                width: 64,
                height: 64,
                borderRadius: 20,
                backgroundColor: colors.purpleBg,
                alignItems: 'center',
                justifyContent: 'center',
                marginBottom: 16,
              }}>
                <Ionicons name="pricetag-outline" size={32} color={colors.purple} />
              </View>
              <Text style={{
                fontSize: 18,
                fontWeight: '700',
                color: colors.ink,
                marginBottom: 8,
                textAlign: 'center',
              }}>
                {t('deals.emptyTitle')}
              </Text>
              <Text style={{
                fontSize: 14,
                color: colors.inkSecondary,
                textAlign: 'center',
                lineHeight: 20,
              }}>
                {t('deals.emptyDesc')}
              </Text>
            </View>
          )}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
