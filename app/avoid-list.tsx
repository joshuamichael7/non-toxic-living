import { useEffect, useState, useCallback } from 'react';
import { View, Text, Pressable, ActivityIndicator, FlatList } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

import { getAvoidListProducts } from '@/services/api/analyze';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239, 68, 68, 0.15)',
};

interface AvoidProduct {
  id: string;
  name: string;
  brand: string | null;
  score: number | null;
  verdict: string | null;
  category: string | null;
  avoid_reason: string | null;
  image_url: string | null;
}

export default function AvoidListScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const [products, setProducts] = useState<AvoidProduct[]>([]);
  const [loading, setLoading] = useState(true);

  const verdictConfig: Record<string, { bg: string; color: string; borderColor: string }> = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic },
  };

  useEffect(() => {
    getAvoidListProducts()
      .then((data) => setProducts(data as AvoidProduct[]))
      .catch(() => setProducts([]))
      .finally(() => setLoading(false));
  }, []);

  const renderItem = ({ item }: { item: AvoidProduct }) => {
    const verdict = (item.verdict || 'caution') as string;
    const config = verdictConfig[verdict] || verdictConfig.caution;

    return (
      <View
        style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 16,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 10,
        }}
      >
        <View style={{ flexDirection: 'row', alignItems: 'center' }}>
          {item.score != null && (
            <View style={{
              width: 52,
              height: 52,
              borderRadius: 16,
              backgroundColor: config.bg,
              alignItems: 'center',
              justifyContent: 'center',
              marginRight: 14,
              borderWidth: 2,
              borderColor: config.borderColor,
            }}>
              <Text style={{ fontSize: 18, fontWeight: '800', color: config.color }}>{item.score}</Text>
            </View>
          )}
          <View style={{ flex: 1 }}>
            <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }} numberOfLines={1}>
              {item.name}
            </Text>
            <Text style={{ fontSize: 13, color: colors.inkSecondary }} numberOfLines={1}>
              {[item.brand, item.category].filter(Boolean).join(' · ')}
            </Text>
          </View>
          <View style={{
            backgroundColor: colors.toxicLight,
            borderRadius: 10,
            paddingVertical: 6,
            paddingHorizontal: 10,
            borderWidth: 1,
            borderColor: colors.toxic,
          }}>
            <Ionicons name="warning" size={14} color={colors.toxic} />
          </View>
        </View>
        {item.avoid_reason && (
          <View style={{
            marginTop: 12,
            paddingTop: 12,
            borderTopWidth: 1,
            borderTopColor: colors.glassBorder,
          }}>
            <Text style={{ fontSize: 13, color: colors.inkSecondary, lineHeight: 18 }}>
              {item.avoid_reason}
            </Text>
          </View>
        )}
      </View>
    );
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      {/* Header */}
      <View style={{ flexDirection: 'row', alignItems: 'center', paddingHorizontal: 20, paddingVertical: 16 }}>
        <Pressable onPress={() => router.back()} style={{ marginRight: 16 }}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={{ fontSize: 20, fontWeight: '700', color: colors.ink }}>
          {t('avoidList.title')}
        </Text>
      </View>

      {loading ? (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <ActivityIndicator size="large" color={colors.oxygen} />
        </View>
      ) : products.length === 0 ? (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 40 }}>
          <View style={{
            width: 80,
            height: 80,
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 20,
          }}>
            <Ionicons name="shield-checkmark-outline" size={36} color={colors.inkMuted} />
          </View>
          <Text style={{ fontSize: 18, fontWeight: '600', color: colors.ink, textAlign: 'center', marginBottom: 8 }}>
            {t('avoidList.empty')}
          </Text>
          <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center', lineHeight: 20 }}>
            {t('avoidList.emptyDesc')}
          </Text>
        </View>
      ) : (
        <FlatList
          data={products}
          renderItem={renderItem}
          keyExtractor={(item) => item.id}
          contentContainerStyle={{ paddingHorizontal: 20, paddingBottom: 40 }}
          showsVerticalScrollIndicator={false}
        />
      )}
    </SafeAreaView>
  );
}
