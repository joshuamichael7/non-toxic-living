import { View, Text, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

import { ScoreBadge } from '@/components/ui/ScoreBadge';

interface Swap {
  id: string;
  name: string;
  brand: string;
  score: number;
  price?: number;
  imageUrl?: string;
  badges?: string[];
}

interface SwapCardProps {
  swap: Swap;
  onPress?: () => void;
}

export function SwapCard({ swap, onPress }: SwapCardProps) {
  const verdict = swap.score >= 67 ? 'safe' : swap.score >= 34 ? 'caution' : 'toxic';

  return (
    <Pressable
      className="bg-white rounded-xl p-4 flex-row items-center shadow-sm border border-stone-100"
      onPress={onPress}
    >
      {/* Product Image Placeholder */}
      <View className="w-16 h-16 bg-stone-100 rounded-lg items-center justify-center">
        <Ionicons name="cube-outline" size={24} color="#A8A29E" />
      </View>

      {/* Product Info */}
      <View className="flex-1 ml-3">
        <Text className="text-stone-900 font-semibold" numberOfLines={1}>
          {swap.name}
        </Text>
        <Text className="text-stone-500 text-sm">{swap.brand}</Text>
        {swap.price && (
          <Text className="text-primary font-semibold mt-1">
            ${swap.price.toFixed(2)}
          </Text>
        )}
      </View>

      {/* Score */}
      <View className="items-center">
        <ScoreBadge score={swap.score} verdict={verdict} size="small" />
        {swap.badges?.includes('dad-approved') && (
          <View className="flex-row items-center mt-1">
            <Ionicons name="checkmark-circle" size={12} color="#10B981" />
            <Text className="text-safe text-xs ml-0.5">Approved</Text>
          </View>
        )}
      </View>
    </Pressable>
  );
}
