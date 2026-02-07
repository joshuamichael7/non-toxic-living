import { View, Text, Pressable } from 'react-native';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

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

// Demo data - will be replaced with real data from store
const DEMO_SCANS = [
  { id: '1', name: 'Cheetos Crunchy', brand: 'Frito-Lay', score: 34, verdict: 'caution' as const },
  { id: '2', name: 'Organic Bananas', brand: 'Whole Foods', score: 92, verdict: 'safe' as const },
  { id: '3', name: 'Tide Pods', brand: 'Procter & Gamble', score: 18, verdict: 'toxic' as const },
];

export function RecentScans() {
  const router = useRouter();
  const { t } = useTranslation();

  const verdictConfig = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe, label: t('verdict.safe') },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution, label: t('verdict.caution') },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic, label: t('verdict.toxic') },
  };

  if (DEMO_SCANS.length === 0) {
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
      {DEMO_SCANS.map((scan) => {
        const config = verdictConfig[scan.verdict];
        return (
          <Pressable
            key={scan.id}
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
            onPress={() => router.push(`/result/${scan.id}`)}
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
              <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }}>
                {scan.name}
              </Text>
              <Text style={{ fontSize: 13, color: colors.inkSecondary }}>
                {scan.brand}
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
