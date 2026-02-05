import { useState } from 'react';
import { View, Text, TextInput, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const POPULAR_SEARCHES = [
  'Non-toxic sunscreen',
  'Safe cookware',
  'Clean shampoo',
  'Organic snacks',
  'PFAS-free products',
  'Natural deodorant',
];

const CATEGORIES = [
  { name: 'Food & Drinks', icon: 'nutrition-outline', color: '#10B981' },
  { name: 'Personal Care', icon: 'body-outline', color: '#F59E0B' },
  { name: 'Household', icon: 'home-outline', color: '#3B82F6' },
  { name: 'Baby & Kids', icon: 'happy-outline', color: '#EC4899' },
  { name: 'Cookware', icon: 'restaurant-outline', color: '#8B5CF6' },
  { name: 'Cleaning', icon: 'sparkles-outline', color: '#06B6D4' },
];

export default function SearchScreen() {
  const [searchQuery, setSearchQuery] = useState('');

  return (
    <SafeAreaView className="flex-1 bg-stone-50" edges={['top']}>
      <ScrollView
        className="flex-1"
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View className="px-6 pt-4 pb-2">
          <Text className="text-2xl font-bold text-stone-900">Search</Text>
          <Text className="text-stone-600 mt-1">
            Find safe alternatives for any product
          </Text>
        </View>

        {/* Search Bar */}
        <View className="px-6 py-4">
          <View className="bg-white rounded-xl flex-row items-center px-4 shadow-sm border border-stone-200">
            <Ionicons name="search" size={20} color="#A8A29E" />
            <TextInput
              className="flex-1 py-4 px-3 text-base text-stone-900"
              placeholder="Search products or ingredients..."
              placeholderTextColor="#A8A29E"
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            {searchQuery.length > 0 && (
              <Pressable onPress={() => setSearchQuery('')}>
                <Ionicons name="close-circle" size={20} color="#A8A29E" />
              </Pressable>
            )}
          </View>
        </View>

        {/* Categories */}
        <View className="px-6 mb-6">
          <Text className="text-lg font-semibold text-stone-900 mb-3">
            Browse Categories
          </Text>
          <View className="flex-row flex-wrap gap-3">
            {CATEGORIES.map((category) => (
              <Pressable
                key={category.name}
                className="bg-white rounded-xl p-4 items-center shadow-sm border border-stone-100"
                style={{ width: '30%' }}
              >
                <View
                  className="w-12 h-12 rounded-full items-center justify-center mb-2"
                  style={{ backgroundColor: `${category.color}20` }}
                >
                  <Ionicons
                    name={category.icon as any}
                    size={24}
                    color={category.color}
                  />
                </View>
                <Text className="text-xs font-medium text-stone-700 text-center">
                  {category.name}
                </Text>
              </Pressable>
            ))}
          </View>
        </View>

        {/* Popular Searches */}
        <View className="px-6">
          <Text className="text-lg font-semibold text-stone-900 mb-3">
            Popular Searches
          </Text>
          <View className="flex-row flex-wrap gap-2">
            {POPULAR_SEARCHES.map((search) => (
              <Pressable
                key={search}
                className="bg-white rounded-full px-4 py-2 border border-stone-200"
                onPress={() => setSearchQuery(search)}
              >
                <Text className="text-stone-700">{search}</Text>
              </Pressable>
            ))}
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
