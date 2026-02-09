import { useEffect, useState, useCallback } from 'react';
import { View, Text, Pressable, ActivityIndicator, FlatList } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter, useLocalSearchParams } from 'expo-router';
import { useFocusEffect } from '@react-navigation/native';
import { useTranslation } from 'react-i18next';

import { useAuthStore } from '@/stores/useAuthStore';
import { getFilteredScans } from '@/services/api/analyze';

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
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239, 68, 68, 0.15)',
};

type FilterTab = 'all' | 'favorites' | 'avoid';

interface ScanItem {
  id: string;
  product_name: string;
  brand: string | null;
  score: number;
  verdict: string;
  created_at: string;
  saved_to_list: string | null;
}

export default function HistoryScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const { filter } = useLocalSearchParams<{ filter?: string }>();
  const user = useAuthStore((s) => s.user);

  const [activeTab, setActiveTab] = useState<FilterTab>((filter as FilterTab) || 'all');
  const [scans, setScans] = useState<ScanItem[]>([]);
  const [loading, setLoading] = useState(true);

  const verdictConfig = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe, label: t('verdict.safe') },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution, label: t('verdict.caution') },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic, label: t('verdict.toxic') },
  };

  const fetchScans = useCallback(async (tab: FilterTab) => {
    if (!user?.id) {
      setLoading(false);
      return;
    }
    setLoading(true);
    try {
      const data = await getFilteredScans(user.id, tab, 50);
      setScans(data as ScanItem[]);
    } catch {
      setScans([]);
    } finally {
      setLoading(false);
    }
  }, [user?.id]);

  // Refresh on focus
  useFocusEffect(
    useCallback(() => {
      fetchScans(activeTab);
    }, [activeTab, fetchScans])
  );

  const handleTabChange = (tab: FilterTab) => {
    setActiveTab(tab);
    fetchScans(tab);
  };

  const tabs: { key: FilterTab; label: string }[] = [
    { key: 'all', label: t('history.all') },
    { key: 'favorites', label: t('history.favorites') },
    { key: 'avoid', label: t('history.avoid') },
  ];

  const emptyMessages: Record<FilterTab, { title: string; desc: string; icon: any }> = {
    all: { title: t('history.empty'), desc: t('history.emptyDesc'), icon: 'scan-outline' },
    favorites: { title: t('history.emptyFavorites'), desc: t('history.emptyFavoritesDesc'), icon: 'heart-outline' },
    avoid: { title: t('history.emptyAvoid'), desc: t('history.emptyAvoidDesc'), icon: 'close-circle-outline' },
  };

  const titleForTab: Record<FilterTab, string> = {
    all: t('history.title'),
    favorites: t('profile.myFavorites'),
    avoid: t('profile.avoidList'),
  };

  const renderScanItem = ({ item: scan }: { item: ScanItem }) => {
    const verdict = (scan.verdict || 'caution') as keyof typeof verdictConfig;
    const config = verdictConfig[verdict] || verdictConfig.caution;
    const date = new Date(scan.created_at);
    const dateStr = date.toLocaleDateString(undefined, { month: 'short', day: 'numeric' });

    return (
      <Pressable
        onPress={() => router.push(`/result/${scan.id}`)}
        style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 16,
          flexDirection: 'row',
          alignItems: 'center',
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 10,
        }}
      >
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
          <Text style={{ fontSize: 18, fontWeight: '800', color: config.color }}>{scan.score}</Text>
        </View>
        <View style={{ flex: 1 }}>
          <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }} numberOfLines={1}>
            {scan.product_name}
          </Text>
          <Text style={{ fontSize: 13, color: colors.inkSecondary }} numberOfLines={1}>
            {scan.brand ? `${scan.brand} · ${dateStr}` : dateStr}
          </Text>
        </View>
        <View style={{
          backgroundColor: config.bg,
          borderRadius: 10,
          paddingVertical: 6,
          paddingHorizontal: 12,
          borderWidth: 1,
          borderColor: config.borderColor,
        }}>
          <Text style={{ fontSize: 12, fontWeight: '600', color: config.color }}>{config.label}</Text>
        </View>
      </Pressable>
    );
  };

  const empty = emptyMessages[activeTab];

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      {/* Header */}
      <View style={{ flexDirection: 'row', alignItems: 'center', paddingHorizontal: 20, paddingVertical: 16 }}>
        <Pressable onPress={() => router.back()} style={{ marginRight: 16 }}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={{ fontSize: 20, fontWeight: '700', color: colors.ink }}>
          {titleForTab[activeTab]}
        </Text>
      </View>

      {/* Segment Control */}
      <View style={{
        flexDirection: 'row',
        marginHorizontal: 20,
        marginBottom: 16,
        backgroundColor: colors.glassSolid,
        borderRadius: 14,
        padding: 4,
        borderWidth: 1,
        borderColor: colors.glassBorder,
      }}>
        {tabs.map((tab) => (
          <Pressable
            key={tab.key}
            onPress={() => handleTabChange(tab.key)}
            style={{
              flex: 1,
              paddingVertical: 10,
              borderRadius: 10,
              backgroundColor: activeTab === tab.key ? colors.oxygen : 'transparent',
              alignItems: 'center',
            }}
          >
            <Text style={{
              fontSize: 14,
              fontWeight: '600',
              color: activeTab === tab.key ? 'white' : colors.inkSecondary,
            }}>
              {tab.label}
            </Text>
          </Pressable>
        ))}
      </View>

      {/* Content */}
      {loading ? (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <ActivityIndicator size="large" color={colors.oxygen} />
        </View>
      ) : !user ? (
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 40 }}>
          <Ionicons name="person-outline" size={48} color={colors.inkMuted} />
          <Text style={{ fontSize: 16, fontWeight: '600', color: colors.ink, marginTop: 16, textAlign: 'center' }}>
            {t('auth.signIn')}
          </Text>
          <Pressable
            onPress={() => router.push('/(auth)/login')}
            style={{
              marginTop: 16,
              backgroundColor: colors.oxygen,
              borderRadius: 14,
              paddingVertical: 12,
              paddingHorizontal: 24,
            }}
          >
            <Text style={{ color: 'white', fontWeight: '600', fontSize: 15 }}>{t('auth.signIn')}</Text>
          </Pressable>
        </View>
      ) : scans.length === 0 ? (
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
            <Ionicons name={empty.icon} size={36} color={colors.inkMuted} />
          </View>
          <Text style={{ fontSize: 18, fontWeight: '600', color: colors.ink, textAlign: 'center', marginBottom: 8 }}>
            {empty.title}
          </Text>
          <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center', lineHeight: 20 }}>
            {empty.desc}
          </Text>
        </View>
      ) : (
        <FlatList
          data={scans}
          renderItem={renderScanItem}
          keyExtractor={(item) => item.id}
          contentContainerStyle={{ paddingHorizontal: 20, paddingBottom: 40 }}
          showsVerticalScrollIndicator={false}
        />
      )}
    </SafeAreaView>
  );
}
