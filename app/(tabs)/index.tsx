import { View, Text, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { InsightCard } from '@/components/home/InsightCard';
import { StatsCard } from '@/components/home/StatsCard';
import { RecentScans } from '@/components/home/RecentScans';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glass: 'rgba(240, 240, 240, 0.85)',
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
  caution: '#F59E0B',
  toxic: '#EF4444',
};

export default function HomeScreen() {
  const router = useRouter();
  const { t } = useTranslation();

  const categories = [
    { name: t('category.food'), icon: 'nutrition-outline' as const },
    { name: t('category.personalCare'), icon: 'body-outline' as const },
    { name: t('category.household'), icon: 'home-outline' as const },
    { name: t('category.baby'), icon: 'happy-outline' as const },
    { name: t('category.cookware'), icon: 'restaurant-outline' as const },
  ];

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }} edges={['top']}>
      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header with Avatar */}
        <View style={{ paddingHorizontal: 24, paddingTop: 16, paddingBottom: 24, flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>
          <View style={{ flexDirection: 'row', alignItems: 'center' }}>
            <View style={{
              width: 48,
              height: 48,
              borderRadius: 24,
              backgroundColor: colors.oxygen,
              alignItems: 'center',
              justifyContent: 'center',
              marginRight: 12,
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 4 },
              shadowOpacity: 0.3,
              shadowRadius: 8,
            }}>
              <Ionicons name="person" size={22} color="white" />
            </View>
            <View>
              <Text style={{ fontSize: 14, color: colors.inkSecondary, fontWeight: '500' }}>{t('home.welcome')}</Text>
              <Text style={{ fontSize: 20, fontWeight: '700', color: colors.ink }}>{t('home.scanAnything')}</Text>
            </View>
          </View>
          <Pressable
            onPress={() => router.push('/notifications')}
            style={{
              width: 44,
              height: 44,
              borderRadius: 22,
              backgroundColor: colors.glassSolid,
              borderWidth: 1,
              borderColor: colors.glassBorder,
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            <Ionicons name="notifications-outline" size={22} color={colors.ink} />
          </Pressable>
        </View>

        {/* Hero Scan Card - Glass with Oxygen Blue accent */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <Pressable
            style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 32,
              padding: 28,
              overflow: 'hidden',
              borderWidth: 1,
              borderColor: colors.glassBorder,
              shadowColor: '#000',
              shadowOffset: { width: 0, height: 8 },
              shadowOpacity: 0.06,
              shadowRadius: 24,
            }}
            onPress={() => router.push('/scan')}
          >
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 16 }}>
              <View style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                backgroundColor: colors.oxygenGlow,
                alignItems: 'center',
                justifyContent: 'center',
                marginRight: 10,
              }}>
                <Ionicons name="scan" size={18} color={colors.oxygen} />
              </View>
              <Text style={{ fontSize: 14, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>
                {t('home.toxinScanner')}
              </Text>
            </View>
            <Text style={{ fontSize: 32, fontWeight: '800', color: colors.ink, marginBottom: 8, lineHeight: 38 }}>
              {t('home.subtitle')}
            </Text>
            <Text style={{ fontSize: 15, color: colors.inkSecondary, marginBottom: 24, lineHeight: 22 }}>
              {t('home.description')}
            </Text>
            <View style={{
              flexDirection: 'row',
              alignItems: 'center',
              backgroundColor: colors.oxygen,
              borderRadius: 16,
              paddingVertical: 16,
              paddingHorizontal: 24,
              alignSelf: 'flex-start',
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 8 },
              shadowOpacity: 0.4,
              shadowRadius: 16,
            }}>
              <Ionicons name="scan" size={20} color="white" />
              <Text style={{ color: 'white', fontWeight: '700', fontSize: 16, marginLeft: 10, letterSpacing: 0.3 }}>
                {t('home.startScanning')}
              </Text>
            </View>
          </Pressable>
        </View>

        {/* Stats Row */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <StatsCard />
        </View>

        {/* Category Pills - Glass style */}
        <View style={{ marginBottom: 24 }}>
          <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, paddingHorizontal: 24, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
            {t('home.categories')}
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={{ paddingHorizontal: 24, gap: 10 }}
          >
            {categories.map((cat, index) => (
              <Pressable
                key={cat.name}
                onPress={() => router.push('/(tabs)/search')}
                style={{
                  backgroundColor: index === 0 ? colors.oxygen : colors.glassSolid,
                  borderRadius: 16,
                  paddingVertical: 12,
                  paddingHorizontal: 16,
                  flexDirection: 'row',
                  alignItems: 'center',
                  borderWidth: 1,
                  borderColor: index === 0 ? colors.oxygen : colors.glassBorder,
                  shadowColor: index === 0 ? colors.oxygen : '#000',
                  shadowOffset: { width: 0, height: 4 },
                  shadowOpacity: index === 0 ? 0.3 : 0.04,
                  shadowRadius: 8,
                }}
              >
                <Ionicons name={cat.icon} size={18} color={index === 0 ? 'white' : colors.ink} style={{ marginRight: 8 }} />
                <Text style={{ fontSize: 14, fontWeight: '600', color: index === 0 ? 'white' : colors.ink }}>{cat.name}</Text>
              </Pressable>
            ))}
          </ScrollView>
        </View>

        {/* Insight Cards */}
        <View style={{ marginBottom: 24 }}>
          <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, paddingHorizontal: 24, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
            {t('home.insights')}
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={{ paddingHorizontal: 24, gap: 12 }}
          >
            <InsightCard
              title={t('insight.didYouKnow')}
              description={t('insight.didYouKnowDesc')}
              icon="alert-circle-outline"
              color="caution"
            />
            <InsightCard
              title={t('insight.tipOfDay')}
              description={t('insight.tipOfDayDesc')}
              icon="bulb-outline"
              color="primary"
            />
            <InsightCard
              title={t('insight.trendingConcern')}
              description={t('insight.trendingConcernDesc')}
              icon="trending-up-outline"
              color="toxic"
            />
          </ScrollView>
        </View>

        {/* Recent Scans */}
        <View style={{ paddingHorizontal: 24 }}>
          <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', marginBottom: 16 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('home.recentScans')}
            </Text>
            <Pressable onPress={() => router.push('/history')}>
              <Text style={{ fontSize: 14, fontWeight: '600', color: colors.oxygen }}>{t('home.seeAll')}</Text>
            </Pressable>
          </View>
          <RecentScans />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
