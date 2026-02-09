import React, { useState, useEffect } from 'react';
import { View, Text, Pressable, Switch, StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';
import AsyncStorage from '@react-native-async-storage/async-storage';

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

const STORAGE_KEY = '@notification_prefs';

interface NotificationPrefs {
  productAlerts: boolean;
  scanReminders: boolean;
  ingredientWarnings: boolean;
  weeklyReport: boolean;
}

const defaultPrefs: NotificationPrefs = {
  productAlerts: true,
  scanReminders: true,
  ingredientWarnings: true,
  weeklyReport: false,
};

const toggleRows: {
  key: keyof NotificationPrefs;
  icon: keyof typeof Ionicons.glyphMap;
  titleKey: string;
  descKey: string;
}[] = [
  {
    key: 'productAlerts',
    icon: 'cube-outline',
    titleKey: 'notifications.productAlerts',
    descKey: 'notifications.productAlertsDesc',
  },
  {
    key: 'scanReminders',
    icon: 'alarm-outline',
    titleKey: 'notifications.scanReminders',
    descKey: 'notifications.scanRemindersDesc',
  },
  {
    key: 'ingredientWarnings',
    icon: 'flask-outline',
    titleKey: 'notifications.ingredientWarnings',
    descKey: 'notifications.ingredientWarningsDesc',
  },
  {
    key: 'weeklyReport',
    icon: 'bar-chart-outline',
    titleKey: 'notifications.weeklyReport',
    descKey: 'notifications.weeklyReportDesc',
  },
];

export default function NotificationsScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const [prefs, setPrefs] = useState<NotificationPrefs>(defaultPrefs);

  useEffect(() => {
    loadPrefs();
  }, []);

  const loadPrefs = async () => {
    try {
      const stored = await AsyncStorage.getItem(STORAGE_KEY);
      if (stored) {
        setPrefs(JSON.parse(stored));
      }
    } catch {
      // Use defaults on error
    }
  };

  const savePrefs = async (updated: NotificationPrefs) => {
    try {
      await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
    } catch {
      // Silently fail
    }
  };

  const handleToggle = (key: keyof NotificationPrefs) => {
    const updated = { ...prefs, [key]: !prefs[key] };
    setPrefs(updated);
    savePrefs(updated);
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Pressable onPress={() => router.back()} hitSlop={12}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={styles.headerTitle}>{t('notifications.title')}</Text>
        <View style={{ width: 28 }} />
      </View>

      <View style={styles.content}>
        <View style={styles.card}>
          {toggleRows.map((row, index) => (
            <View key={row.key}>
              {index > 0 && <View style={styles.separator} />}
              <View style={styles.row}>
                <View style={styles.iconContainer}>
                  <Ionicons name={row.icon} size={22} color={colors.oxygen} />
                </View>
                <View style={styles.textContainer}>
                  <Text style={styles.rowTitle}>{t(row.titleKey)}</Text>
                  <Text style={styles.rowDesc}>{t(row.descKey)}</Text>
                </View>
                <Switch
                  value={prefs[row.key]}
                  onValueChange={() => handleToggle(row.key)}
                  trackColor={{ false: '#D1D5DB', true: colors.oxygen }}
                  thumbColor="white"
                />
              </View>
            </View>
          ))}
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.canvas,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: colors.ink,
  },
  content: {
    paddingHorizontal: 20,
    paddingTop: 8,
  },
  card: {
    backgroundColor: colors.glassSolid,
    borderRadius: 24,
    borderWidth: 1,
    borderColor: colors.glassBorder,
    padding: 8,
  },
  separator: {
    height: 1,
    backgroundColor: colors.glassBorder,
    marginHorizontal: 12,
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  iconContainer: {
    width: 40,
    height: 40,
    backgroundColor: colors.canvas,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 14,
  },
  textContainer: {
    flex: 1,
    marginRight: 12,
  },
  rowTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: colors.ink,
    marginBottom: 2,
  },
  rowDesc: {
    fontSize: 13,
    color: colors.inkSecondary,
    lineHeight: 18,
  },
});
