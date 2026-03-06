import { View, Text, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

import { useCreditStore } from '@/stores/useSubscriptionStore';

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
  cautionGlow: 'rgba(245, 158, 11, 0.12)',
};

const LOW_CREDITS_THRESHOLD = 20;

export function ScanQuotaTracker() {
  const { t } = useTranslation();
  const router = useRouter();
  const { credits } = useCreditStore();

  const isLow = credits > 0 && credits <= LOW_CREDITS_THRESHOLD;
  const isEmpty = credits <= 0;
  const accentColor = isEmpty || isLow ? colors.caution : colors.oxygen;
  const accentGlow = isEmpty || isLow ? colors.cautionGlow : colors.oxygenGlow;

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
            backgroundColor: accentGlow,
            borderRadius: 10,
            alignItems: 'center',
            justifyContent: 'center',
          }}>
            <Ionicons name="scan-outline" size={18} color={accentColor} />
          </View>
          <Text style={{ marginLeft: 10, fontSize: 14, fontWeight: '700', color: colors.ink }}>
            {t('quota.scanUsage')}
          </Text>
        </View>

        {/* Credit balance */}
        <Text style={{ fontSize: 28, fontWeight: '900', color: colors.ink, marginBottom: 4 }}>
          {credits}
        </Text>
        <Text style={{ fontSize: 14, color: colors.inkSecondary, marginBottom: 2 }}>
          {t('credits.balance', { count: credits })}
        </Text>
        <Text style={{ fontSize: 12, color: colors.inkMuted, marginBottom: 14 }}>
          1 credit per scan · never expire
        </Text>

        {/* Low credits prompt */}
        {(isLow || isEmpty) && (
          <Pressable
            onPress={() => router.push('/subscription' as any)}
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'space-between',
              backgroundColor: colors.cautionGlow,
              borderRadius: 12,
              paddingHorizontal: 14,
              paddingVertical: 10,
            }}
          >
            <Text style={{ color: colors.caution, fontWeight: '600', fontSize: 13 }}>
              {isEmpty ? t('credits.outTitle') : t('credits.lowCredits')}
            </Text>
            <View style={{
              backgroundColor: colors.caution,
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
