import { View, Text, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

import { ScoreBadge } from '@/components/ui/ScoreBadge';
import { SwapCard } from '@/components/swaps/SwapCard';

// Demo data - will be replaced with real scan result
const DEMO_RESULT = {
  productName: 'Cheetos Crunchy',
  brand: 'Frito-Lay',
  score: 34,
  verdict: 'caution' as const,
  summary: 'Contains several artificial additives and highly processed ingredients that may have negative health effects.',
  dadsTake: "I keep these out of my house. The artificial colors and MSG derivatives aren't worth it when there are better options that taste just as good.",
  concerns: [
    { ingredient: 'Yellow 6', severity: 'medium', description: 'Artificial color linked to hyperactivity in children' },
    { ingredient: 'Red 40', severity: 'medium', description: 'Synthetic dye with potential carcinogenic properties' },
    { ingredient: 'MSG', severity: 'low', description: 'Flavor enhancer that may cause sensitivity reactions' },
  ],
  positives: ['No trans fats', 'Gluten-free'],
  swaps: [
    { id: '1', name: 'Lesser Evil Paleo Puffs', brand: 'Lesser Evil', score: 82, price: 4.99 },
    { id: '2', name: 'Hippeas Organic Chickpea Puffs', brand: 'Hippeas', score: 78, price: 3.99 },
  ],
};

export default function ResultScreen() {
  const { id } = useLocalSearchParams();
  const router = useRouter();

  const result = DEMO_RESULT;
  const verdictColors = {
    safe: { bg: 'bg-safe-light', text: 'text-safe', border: 'border-safe' },
    caution: { bg: 'bg-caution-light', text: 'text-caution', border: 'border-caution' },
    toxic: { bg: 'bg-toxic-light', text: 'text-toxic', border: 'border-toxic' },
  };

  const colors = verdictColors[result.verdict];

  return (
    <SafeAreaView className="flex-1 bg-stone-50" edges={['top']}>
      {/* Header */}
      <View className="flex-row items-center justify-between px-4 py-2 border-b border-stone-200">
        <Pressable
          className="w-10 h-10 items-center justify-center"
          onPress={() => router.back()}
        >
          <Ionicons name="close" size={28} color="#1C1917" />
        </Pressable>
        <Text className="text-lg font-semibold text-stone-900">Scan Result</Text>
        <Pressable className="w-10 h-10 items-center justify-center">
          <Ionicons name="share-outline" size={24} color="#1C1917" />
        </Pressable>
      </View>

      <ScrollView
        className="flex-1"
        contentContainerStyle={{ paddingBottom: 40 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Product Info & Score */}
        <View className="items-center pt-6 pb-4 px-6">
          <ScoreBadge score={result.score} verdict={result.verdict} size="large" />
          <Text className="text-2xl font-bold text-stone-900 mt-4 text-center">
            {result.productName}
          </Text>
          <Text className="text-stone-500 text-base">{result.brand}</Text>
          <View className={`mt-3 px-4 py-1 rounded-full ${colors.bg}`}>
            <Text className={`font-semibold capitalize ${colors.text}`}>
              {result.verdict}
            </Text>
          </View>
        </View>

        {/* Summary */}
        <View className="px-6 mb-4">
          <View className="bg-white rounded-xl p-4 shadow-sm">
            <Text className="text-stone-700 leading-relaxed">{result.summary}</Text>
          </View>
        </View>

        {/* Dad's Take */}
        <View className="px-6 mb-4">
          <View className={`rounded-xl p-4 ${colors.bg} border ${colors.border}`}>
            <View className="flex-row items-center mb-2">
              <Ionicons name="chatbubble-outline" size={18} color="#57534E" />
              <Text className="font-semibold text-stone-700 ml-2">Dad's Take</Text>
            </View>
            <Text className="text-stone-600 italic leading-relaxed">
              "{result.dadsTake}"
            </Text>
          </View>
        </View>

        {/* Concerns */}
        <View className="px-6 mb-4">
          <Text className="text-lg font-semibold text-stone-900 mb-3">
            Concerns ({result.concerns.length})
          </Text>
          <View className="bg-white rounded-xl overflow-hidden shadow-sm">
            {result.concerns.map((concern, index) => (
              <View
                key={concern.ingredient}
                className={`p-4 ${index < result.concerns.length - 1 ? 'border-b border-stone-100' : ''}`}
              >
                <View className="flex-row items-center justify-between mb-1">
                  <Text className="font-semibold text-stone-900">
                    {concern.ingredient}
                  </Text>
                  <View
                    className={`px-2 py-0.5 rounded-full ${
                      concern.severity === 'high'
                        ? 'bg-toxic-light'
                        : concern.severity === 'medium'
                        ? 'bg-caution-light'
                        : 'bg-stone-100'
                    }`}
                  >
                    <Text
                      className={`text-xs font-medium capitalize ${
                        concern.severity === 'high'
                          ? 'text-toxic'
                          : concern.severity === 'medium'
                          ? 'text-caution'
                          : 'text-stone-600'
                      }`}
                    >
                      {concern.severity}
                    </Text>
                  </View>
                </View>
                <Text className="text-stone-600 text-sm">{concern.description}</Text>
              </View>
            ))}
          </View>
        </View>

        {/* Positives */}
        {result.positives.length > 0 && (
          <View className="px-6 mb-4">
            <Text className="text-lg font-semibold text-stone-900 mb-3">
              Positives
            </Text>
            <View className="flex-row flex-wrap gap-2">
              {result.positives.map((positive) => (
                <View key={positive} className="bg-safe-light rounded-full px-3 py-1.5 flex-row items-center">
                  <Ionicons name="checkmark-circle" size={16} color="#10B981" />
                  <Text className="text-safe font-medium ml-1">{positive}</Text>
                </View>
              ))}
            </View>
          </View>
        )}

        {/* Safe Swaps */}
        {result.swaps.length > 0 && (
          <View className="px-6">
            <Text className="text-lg font-semibold text-stone-900 mb-3">
              Better Alternatives
            </Text>
            <View className="gap-3">
              {result.swaps.map((swap) => (
                <SwapCard key={swap.id} swap={swap} />
              ))}
            </View>
          </View>
        )}
      </ScrollView>

      {/* Bottom Actions */}
      <View className="px-6 py-4 border-t border-stone-200 bg-white">
        <View className="flex-row gap-3">
          <Pressable className="flex-1 bg-stone-100 rounded-xl py-3 flex-row items-center justify-center">
            <Ionicons name="heart-outline" size={20} color="#57534E" />
            <Text className="text-stone-700 font-medium ml-2">Save</Text>
          </Pressable>
          <Pressable className="flex-1 bg-primary rounded-xl py-3 flex-row items-center justify-center">
            <Ionicons name="scan-outline" size={20} color="white" />
            <Text className="text-white font-medium ml-2">Scan Again</Text>
          </Pressable>
        </View>
      </View>
    </SafeAreaView>
  );
}
