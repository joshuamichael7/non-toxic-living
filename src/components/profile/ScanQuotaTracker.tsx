import { useState, useEffect, useRef } from 'react';
import { View, Text, Pressable, Animated } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

import { supabase } from '@/lib/supabase';
import { useAuthStore } from '@/stores/useAuthStore';
import { useSubscriptionStore } from '@/stores/useSubscriptionStore';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  caution: '#F59E0B',
  toxic: '#EF4444',
};

const TIER_LIMITS: Record<string, number> = { free: 5, pro: 200, power: 500 };

export function ScanQuotaTracker() {
  const { t } = useTranslation();
  const router = useRouter();
  const { user } = useAuthStore();
  const { tier } = useSubscriptionStore();

  const [scansUsed, setScansUsed] = useState(0);
  const [resetsAt, setResetsAt] = useState<string | null>(null);
  const animatedWidth = useRef(new Animated.Value(0)).current;

  const limit = TIER_LIMITS[tier] || 5;
  const percentage = Math.min(scansUsed / limit, 1);

  const barColor = percentage > 0.85
    ? colors.toxic
    : percentage > 0.6
      ? colors.caution
      : colors.oxygen;

  useEffect(() => {
    if (!user?.id) return;

    (supabase as any)
      .from('profiles')
      .select('scans_this_month, scans_month_reset_at')
      .eq('id', user.id)
      .single()
      .then(({ data }: any) => {
        if (data) {
          setScansUsed(data.scans_this_month || 0);
          setResetsAt(data.scans_month_reset_at);
        }
      });
  }, [user?.id]);

  useEffect(() => {
    Animated.timing(animatedWidth, {
      toValue: percentage,
      duration: 800,
      useNativeDriver: false,
    }).start();
  }, [percentage]);

  const resetDateFormatted = resetsAt
    ? new Date(resetsAt).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })
    : null;

  const showUpgradePrompt = tier === 'free' && percentage > 0.6;

  return (
    <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
      <View style={{
        backgroundColor: colors.glassSolid,
        borderRadius: 24,
        padding: 20,
        borderWidth: 1,
        borderColor: colors.glassBorder,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.04,
        shadowRadius: 12,
      }}>
        {/* Header */}
        <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 14 }}>
          <View style={{
            width: 36,
            height: 36,
            backgroundColor: colors.oxygenGlow,
            borderRadius: 10,
            alignItems: 'center',
            justifyContent: 'center',
          }}>
            <Ionicons name="speedometer-outline" size={18} color={colors.oxygen} />
          </View>
          <Text style={{ marginLeft: 10, fontSize: 14, fontWeight: '700', color: colors.ink }}>
            {t('quota.scanUsage')}
          </Text>
        </View>

        {/* Count */}
        <Text style={{ fontSize: 15, color: colors.ink, marginBottom: 10 }}>
          <Text style={{ fontWeight: '800' }}>{scansUsed}</Text>
          <Text style={{ color: colors.inkSecondary }}> / {limit} </Text>
          <Text style={{ color: colors.inkSecondary }}>{t('quota.scansThisMonth')}</Text>
        </Text>

        {/* Progress bar */}
        <View style={{
          width: '100%',
          height: 8,
          backgroundColor: colors.canvas,
          borderRadius: 4,
          overflow: 'hidden',
          marginBottom: 8,
        }}>
          <Animated.View style={{
            width: animatedWidth.interpolate({
              inputRange: [0, 1],
              outputRange: ['0%', '100%'],
            }),
            height: '100%',
            backgroundColor: barColor,
            borderRadius: 4,
          }} />
        </View>

        {/* Reset date */}
        {resetDateFormatted && (
          <Text style={{ fontSize: 12, color: colors.inkMuted }}>
            {t('quota.resetsOn', { date: resetDateFormatted })}
          </Text>
        )}

        {/* Upgrade prompt */}
        {showUpgradePrompt && (
          <Pressable
            onPress={() => router.push('/subscription' as any)}
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'space-between',
              marginTop: 14,
              backgroundColor: colors.oxygenGlow,
              borderRadius: 12,
              paddingHorizontal: 14,
              paddingVertical: 10,
            }}
          >
            <Text style={{ color: colors.oxygen, fontWeight: '600', fontSize: 13 }}>
              {t('quota.upgradePrompt')}
            </Text>
            <View style={{
              backgroundColor: colors.oxygen,
              borderRadius: 8,
              paddingHorizontal: 12,
              paddingVertical: 6,
            }}>
              <Text style={{ color: 'white', fontWeight: '700', fontSize: 12 }}>
                {t('quota.upgrade')}
              </Text>
            </View>
          </Pressable>
        )}
      </View>
    </View>
  );
}
