import { useState } from 'react';
import { View, Text, TextInput, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

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
};

export default function SearchScreen() {
  const [searchQuery, setSearchQuery] = useState('');
  const { t } = useTranslation();

  const categories = [
    { name: t('category.foodDrinks'), icon: 'nutrition-outline' as const },
    { name: t('category.personalCare'), icon: 'body-outline' as const },
    { name: t('category.household'), icon: 'home-outline' as const },
    { name: t('category.babyKids'), icon: 'happy-outline' as const },
    { name: t('category.cookware'), icon: 'restaurant-outline' as const },
    { name: t('category.cleaning'), icon: 'sparkles-outline' as const },
  ];

  const popularSearches = [
    t('search.nonToxicSunscreen'),
    t('search.safeCookware'),
    t('search.cleanShampoo'),
    t('search.organicSnacks'),
    t('search.pfasFree'),
    t('search.naturalDeodorant'),
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
            />
            {searchQuery.length > 0 && (
              <Pressable onPress={() => setSearchQuery('')}>
                <Ionicons name="close-circle" size={20} color={colors.inkMuted} />
              </Pressable>
            )}
          </View>
        </View>

        {/* Categories */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
            {t('search.categories')}
          </Text>
          <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 12 }}>
            {categories.map((category, index) => (
              <Pressable
                key={category.name}
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
                key={search}
                style={{
                  backgroundColor: colors.glassSolid,
                  borderRadius: 12,
                  paddingHorizontal: 16,
                  paddingVertical: 10,
                  borderWidth: 1,
                  borderColor: colors.glassBorder,
                }}
                onPress={() => setSearchQuery(search)}
              >
                <Text style={{ color: colors.ink, fontWeight: '500' }}>{search}</Text>
              </Pressable>
            ))}
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
