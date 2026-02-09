import React from 'react';
import { View, Text, Pressable, ScrollView, Linking, StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

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

const linkRows: {
  icon: keyof typeof Ionicons.glyphMap;
  labelKey: string;
  url: string;
}[] = [
  {
    icon: 'shield-outline',
    labelKey: 'about.privacyPolicy',
    url: 'https://nontoxicliving.app/privacy',
  },
  {
    icon: 'document-text-outline',
    labelKey: 'about.termsOfService',
    url: 'https://nontoxicliving.app/terms',
  },
];

export default function AboutScreen() {
  const router = useRouter();
  const { t } = useTranslation();

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Pressable onPress={() => router.back()} hitSlop={12}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={styles.headerTitle}>{t('about.title')}</Text>
        <View style={{ width: 28 }} />
      </View>

      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* App Icon */}
        <View style={styles.centeredSection}>
          <View style={styles.appIcon}>
            <Ionicons name="leaf" size={48} color={colors.oxygen} />
          </View>
          <Text style={styles.appName}>{t('about.appName')}</Text>
          <Text style={styles.version}>
            {t('profile.version', { version: '1.0.0' })}
          </Text>
        </View>

        {/* Mission Card */}
        <View style={styles.card}>
          <Text style={styles.missionTitle}>{t('about.missionTitle')}</Text>
          <Text style={styles.missionText}>{t('about.mission')}</Text>
        </View>

        {/* Links Section */}
        <View style={styles.card}>
          {linkRows.map((link, index) => (
            <View key={index}>
              {index > 0 && <View style={styles.separator} />}
              <Pressable
                style={styles.linkRow}
                onPress={() => Linking.openURL(link.url)}
              >
                <View style={styles.linkIconContainer}>
                  <Ionicons name={link.icon} size={22} color={colors.oxygen} />
                </View>
                <Text style={styles.linkLabel}>{t(link.labelKey)}</Text>
                <Ionicons
                  name="chevron-forward"
                  size={18}
                  color={colors.inkMuted}
                />
              </Pressable>
            </View>
          ))}
        </View>

        {/* Credits */}
        <Text style={styles.credits}>{t('about.creditsDesc')}</Text>
      </ScrollView>
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
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: 20,
    paddingBottom: 100,
  },
  centeredSection: {
    alignItems: 'center',
    marginTop: 24,
    marginBottom: 32,
  },
  appIcon: {
    width: 100,
    height: 100,
    backgroundColor: colors.oxygenGlow,
    borderRadius: 32,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
  },
  appName: {
    fontSize: 24,
    fontWeight: '800',
    color: colors.ink,
    marginBottom: 4,
  },
  version: {
    fontSize: 14,
    color: colors.inkMuted,
  },
  card: {
    backgroundColor: colors.glassSolid,
    borderRadius: 24,
    borderWidth: 1,
    borderColor: colors.glassBorder,
    padding: 20,
    marginBottom: 16,
  },
  missionTitle: {
    fontSize: 17,
    fontWeight: '700',
    color: colors.ink,
    marginBottom: 8,
  },
  missionText: {
    fontSize: 15,
    color: colors.inkSecondary,
    lineHeight: 23,
  },
  separator: {
    height: 1,
    backgroundColor: colors.glassBorder,
    marginVertical: 4,
  },
  linkRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  linkIconContainer: {
    width: 40,
    height: 40,
    backgroundColor: colors.canvas,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 14,
  },
  linkLabel: {
    flex: 1,
    fontSize: 16,
    fontWeight: '600',
    color: colors.ink,
  },
  credits: {
    fontSize: 13,
    color: colors.inkMuted,
    textAlign: 'center',
    lineHeight: 20,
    marginTop: 16,
    paddingHorizontal: 20,
  },
});
