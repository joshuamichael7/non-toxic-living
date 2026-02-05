import { View, Text, Pressable } from 'react-native';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

import { ScoreBadge } from '@/components/ui/ScoreBadge';

// Demo data - will be replaced with real data from store
const DEMO_SCANS = [
  { id: '1', name: 'Cheetos Crunchy', brand: 'Frito-Lay', score: 34, verdict: 'caution' as const },
  { id: '2', name: 'Organic Bananas', brand: 'Whole Foods', score: 92, verdict: 'safe' as const },
  { id: '3', name: 'Tide Pods', brand: 'Procter & Gamble', score: 18, verdict: 'toxic' as const },
];

export function RecentScans() {
  const router = useRouter();

  if (DEMO_SCANS.length === 0) {
    return (
      <View className="bg-white rounded-2xl p-6 items-center shadow-sm">
        <View className="w-16 h-16 bg-stone-100 rounded-full items-center justify-center mb-3">
          <Ionicons name="scan-outline" size={32} color="#A8A29E" />
        </View>
        <Text className="text-stone-900 font-semibold text-base mb-1">No scans yet</Text>
        <Text className="text-stone-500 text-sm text-center">
          Start scanning products to see your history here
        </Text>
      </View>
    );
  }

  return (
    <View className="bg-white rounded-2xl overflow-hidden shadow-sm">
      {DEMO_SCANS.map((scan, index) => (
        <Pressable
          key={scan.id}
          className={`flex-row items-center p-4 ${
            index < DEMO_SCANS.length - 1 ? 'border-b border-stone-100' : ''
          }`}
          onPress={() => router.push(`/result/${scan.id}`)}
        >
          <ScoreBadge score={scan.score} verdict={scan.verdict} size="small" />
          <View className="flex-1 ml-3">
            <Text className="text-stone-900 font-medium">{scan.name}</Text>
            <Text className="text-stone-500 text-sm">{scan.brand}</Text>
          </View>
          <Ionicons name="chevron-forward" size={20} color="#A8A29E" />
        </Pressable>
      ))}
    </View>
  );
}
