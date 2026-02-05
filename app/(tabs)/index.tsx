import { View, Text, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

import { InsightCard } from '@/components/home/InsightCard';
import { StatsCard } from '@/components/home/StatsCard';
import { RecentScans } from '@/components/home/RecentScans';

export default function HomeScreen() {
  const router = useRouter();

  return (
    <SafeAreaView className="flex-1 bg-stone-50" edges={['top']}>
      <ScrollView
        className="flex-1"
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View className="px-6 pt-4 pb-6">
          <Text className="text-3xl font-bold text-stone-900">
            Good morning
          </Text>
          <Text className="text-base text-stone-600 mt-1">
            Let's make healthier choices today
          </Text>
        </View>

        {/* Stats Cards */}
        <View className="px-6 mb-6">
          <StatsCard
            toxinsAvoided={12}
            scansThisWeek={8}
            streakDays={5}
          />
        </View>

        {/* Insight Cards - Horizontal Scroll */}
        <View className="mb-6">
          <Text className="text-lg font-semibold text-stone-900 px-6 mb-3">
            Daily Insights
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={{ paddingHorizontal: 24, gap: 12 }}
          >
            <InsightCard
              title="Did you know?"
              description="98% of non-stick pans contain PFAS, linked to hormone disruption."
              icon="alert-circle-outline"
              color="caution"
            />
            <InsightCard
              title="Tip of the day"
              description="Check for 'fragrance' in products - it can hide hundreds of chemicals."
              icon="bulb-outline"
              color="safe"
            />
            <InsightCard
              title="Trending concern"
              description="Titanium dioxide is now banned in EU food products."
              icon="trending-up-outline"
              color="toxic"
            />
          </ScrollView>
        </View>

        {/* Quick Scan Button */}
        <View className="px-6 mb-6">
          <Pressable
            className="bg-primary rounded-xl p-4 flex-row items-center justify-center active:bg-primary-dark"
            onPress={() => router.push('/scan')}
          >
            <Ionicons name="scan" size={24} color="white" />
            <Text className="text-white text-lg font-semibold ml-2">
              Scan a Product
            </Text>
          </Pressable>
        </View>

        {/* Recent Scans */}
        <View className="px-6">
          <Text className="text-lg font-semibold text-stone-900 mb-3">
            Recent Scans
          </Text>
          <RecentScans />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
