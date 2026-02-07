import { View, Text } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

// Aerogel Design System Colors
const colors = {
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  safe: '#10B981',
  safeGlow: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionGlow: 'rgba(245, 158, 11, 0.15)',
};

interface StatsCardProps {
  toxinsAvoided: number;
  scansThisWeek: number;
  streakDays: number;
}

export function StatsCard({ toxinsAvoided, scansThisWeek, streakDays }: StatsCardProps) {
  const { t } = useTranslation();
  return (
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
      <View style={{ flexDirection: 'row', gap: 16 }}>
        {/* Toxins Avoided */}
        <View style={{ flex: 1, alignItems: 'center' }}>
          <View style={{
            width: 48,
            height: 48,
            borderRadius: 16,
            backgroundColor: colors.safeGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 10,
          }}>
            <Ionicons name="shield-checkmark" size={24} color={colors.safe} />
          </View>
          <Text style={{ fontSize: 24, fontWeight: '800', color: colors.ink }}>{toxinsAvoided}</Text>
          <Text style={{ fontSize: 11, color: colors.inkSecondary, textAlign: 'center', marginTop: 2, fontWeight: '500' }}>
            {t('stats.toxinsAvoided')}
          </Text>
        </View>

        {/* Divider */}
        <View style={{ width: 1, backgroundColor: colors.glassBorder, marginVertical: 8 }} />

        {/* Scans This Week */}
        <View style={{ flex: 1, alignItems: 'center' }}>
          <View style={{
            width: 48,
            height: 48,
            borderRadius: 16,
            backgroundColor: colors.oxygenGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 10,
          }}>
            <Ionicons name="scan" size={24} color={colors.oxygen} />
          </View>
          <Text style={{ fontSize: 24, fontWeight: '800', color: colors.ink }}>{scansThisWeek}</Text>
          <Text style={{ fontSize: 11, color: colors.inkSecondary, textAlign: 'center', marginTop: 2, fontWeight: '500' }}>
            {t('stats.thisWeek')}
          </Text>
        </View>

        {/* Divider */}
        <View style={{ width: 1, backgroundColor: colors.glassBorder, marginVertical: 8 }} />

        {/* Streak */}
        <View style={{ flex: 1, alignItems: 'center' }}>
          <View style={{
            width: 48,
            height: 48,
            borderRadius: 16,
            backgroundColor: colors.cautionGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 10,
          }}>
            <Ionicons name="flame" size={24} color={colors.caution} />
          </View>
          <Text style={{ fontSize: 24, fontWeight: '800', color: colors.ink }}>{streakDays}</Text>
          <Text style={{ fontSize: 11, color: colors.inkSecondary, textAlign: 'center', marginTop: 2, fontWeight: '500' }}>
            {t('stats.dayStreak')}
          </Text>
        </View>
      </View>
    </View>
  );
}
