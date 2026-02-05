import { View, Text } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

interface StatsCardProps {
  toxinsAvoided: number;
  scansThisWeek: number;
  streakDays: number;
}

export function StatsCard({ toxinsAvoided, scansThisWeek, streakDays }: StatsCardProps) {
  return (
    <View className="bg-white rounded-2xl p-4 shadow-sm">
      <View className="flex-row">
        <View className="flex-1 items-center py-2">
          <View className="w-12 h-12 bg-safe-light rounded-full items-center justify-center mb-2">
            <Ionicons name="shield-checkmark" size={24} color="#10B981" />
          </View>
          <Text className="text-2xl font-bold text-stone-900">{toxinsAvoided}</Text>
          <Text className="text-stone-500 text-xs text-center">Toxins{'\n'}Avoided</Text>
        </View>

        <View className="w-px bg-stone-100" />

        <View className="flex-1 items-center py-2">
          <View className="w-12 h-12 bg-primary/10 rounded-full items-center justify-center mb-2">
            <Ionicons name="scan" size={24} color="#059669" />
          </View>
          <Text className="text-2xl font-bold text-stone-900">{scansThisWeek}</Text>
          <Text className="text-stone-500 text-xs text-center">Scans{'\n'}This Week</Text>
        </View>

        <View className="w-px bg-stone-100" />

        <View className="flex-1 items-center py-2">
          <View className="w-12 h-12 bg-caution-light rounded-full items-center justify-center mb-2">
            <Ionicons name="flame" size={24} color="#F59E0B" />
          </View>
          <Text className="text-2xl font-bold text-stone-900">{streakDays}</Text>
          <Text className="text-stone-500 text-xs text-center">Day{'\n'}Streak</Text>
        </View>
      </View>
    </View>
  );
}
