import { useEffect, useState, useCallback } from 'react';
import { View, Text, Pressable, ActivityIndicator } from 'react-native';
import { useRouter } from 'expo-router';
import { useFocusEffect } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { useAuthStore } from '@/stores/useAuthStore';
import { getUserScans } from '@/services/api/analyze';

// Aerogel Design System Colors
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

interface ScanItem {
  id: string;
  product_name: string;
  brand: string | null;
  score: number;
  verdict: string;
  created_at: string;
}

export function RecentScans() {
  const router = useRouter();
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const [scans, setScans] = useState<ScanItem[]>([]);
  const [loading, setLoading] = useState(true);

  useFocusEffect(
    useCallback(() => {
      if (!user?.id) {
        setLoading(false);
        return;
      }
      getUserScans(user.id, 5)
        .then((data) => setScans(data as ScanItem[]))
        .catch(() => {})
        .finally(() => setLoading(false));
    }, [user?.id])
  );

  const verdictConfig = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe, label: t('verdict.safe') },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution, label: t('verdict.caution') },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic, label: t('verdict.toxic') },
  };

  if (loading) {
    return (
      <View style={{ padding: 32, alignItems: 'center' }}>
        <ActivityIndicator size="small" color={colors.oxygen} />
      </View>
    );
  }

  if (scans.length === 0) {
    return (
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
          backgroundColor: colors.canvas,
          borderRadius: 20,
          alignItems: 'center',
          justifyContent: 'center',
          marginBottom: 16,
        }}>
          <Ionicons name="scan-outline" size={28} color={colors.inkMuted} />
        </View>
        <Text style={{ fontSize: 16, fontWeight: '600', color: colors.ink, marginBottom: 4 }}>
          {t('recentScans.noScans')}
        </Text>
        <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center' }}>
          {t('recentScans.noScansDesc')}
        </Text>
      </View>
    );
  }

  return (
    <View style={{ gap: 12 }}>
      {scans.map((scan) => {
        const verdict = (scan.verdict || 'caution') as keyof typeof verdictConfig;
        const config = verdictConfig[verdict] || verdictConfig.caution;
        return (
          <Pressable
            key={scan.id}
            onPress={() => router.push(`/result/${scan.id}`)}
            style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 20,
              padding: 16,
              flexDirection: 'row',
              alignItems: 'center',
              borderWidth: 1,
              borderColor: colors.glassBorder,
              shadowColor: '#000',
              shadowOffset: { width: 0, height: 2 },
              shadowOpacity: 0.04,
              shadowRadius: 8,
            }}
          >
            {/* Score Circle */}
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
              <Text style={{ fontSize: 18, fontWeight: '800', color: config.color }}>
                {scan.score}
              </Text>
            </View>

            {/* Product Info */}
            <View style={{ flex: 1 }}>
              <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }} numberOfLines={1}>
                {scan.product_name}
              </Text>
              <Text style={{ fontSize: 13, color: colors.inkSecondary }} numberOfLines={1}>
                {scan.brand || ''}
              </Text>
            </View>

            {/* Verdict Pill */}
            <View style={{
              backgroundColor: config.bg,
              borderRadius: 10,
              paddingVertical: 6,
              paddingHorizontal: 12,
              borderWidth: 1,
              borderColor: config.borderColor,
            }}>
              <Text style={{ fontSize: 12, fontWeight: '600', color: config.color }}>
                {config.label}
              </Text>
            </View>
          </Pressable>
        );
      })}
    </View>
  );
}
