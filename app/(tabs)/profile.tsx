import { useState } from 'react';
import { View, Text, ScrollView, Pressable, Share, Modal } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

import { getScanLogs } from '@/services/api/analyze';
import { usePreferencesStore, SUPPORTED_LANGUAGES } from '@/stores/usePreferencesStore';
import { useAuthStore } from '@/stores/useAuthStore';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  oxygenDeep: '#0284C7',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  error: '#EF4444',
};

export default function ProfileScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const [showLanguagePicker, setShowLanguagePicker] = useState(false);

  const { language, setLanguage } = usePreferencesStore();
  const { user, signOut } = useAuthStore();

  const currentLanguageLabel = SUPPORTED_LANGUAGES.find(l => l.code === language)?.label ?? 'English';

  const menuItems = [
    { title: t('profile.myFavorites'), icon: 'heart-outline' as const, badge: 12 },
    { title: t('profile.avoidList'), icon: 'close-circle-outline' as const, badge: 8 },
    { title: t('profile.scanHistory'), icon: 'time-outline' as const },
    { title: t('profile.language'), icon: 'language-outline' as const, subtitle: currentLanguageLabel, onPress: () => setShowLanguagePicker(true) },
    { title: t('profile.notifications'), icon: 'notifications-outline' as const },
    { title: t('profile.helpSupport'), icon: 'help-circle-outline' as const },
    { title: t('profile.about'), icon: 'information-circle-outline' as const },
  ];

  const handleExportLogs = async () => {
    const logs = await getScanLogs();
    const text = JSON.stringify(logs, null, 2);
    await Share.share({ message: text, title: 'Scan Logs' });
  };

  const handleSignOut = async () => {
    await signOut();
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }} edges={['top']}>
      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={{ paddingHorizontal: 24, paddingTop: 16, paddingBottom: 24 }}>
          <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>{t('profile.title')}</Text>
        </View>

        {/* Profile Card */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            padding: 24,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04,
            shadowRadius: 12,
          }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 20 }}>
              <View style={{
                width: 64,
                height: 64,
                backgroundColor: colors.oxygenGlow,
                borderRadius: 20,
                alignItems: 'center',
                justifyContent: 'center',
              }}>
                <Ionicons name="person" size={32} color={colors.oxygen} />
              </View>
              <View style={{ marginLeft: 16, flex: 1 }}>
                <Text style={{ fontSize: 18, fontWeight: '700', color: colors.ink }}>
                  {user ? user.email : t('profile.guestUser')}
                </Text>
                <Text style={{ color: colors.inkSecondary, fontSize: 14, marginTop: 2 }}>
                  {t('profile.freePlan')}
                </Text>
              </View>
              {user ? (
                <Pressable
                  onPress={handleSignOut}
                  style={{
                    backgroundColor: colors.canvas,
                    borderRadius: 12,
                    paddingHorizontal: 16,
                    paddingVertical: 10,
                    borderWidth: 1,
                    borderColor: colors.glassBorder,
                  }}
                >
                  <Text style={{ color: colors.inkSecondary, fontWeight: '600', fontSize: 14 }}>
                    {t('profile.signOut')}
                  </Text>
                </Pressable>
              ) : (
                <Pressable
                  onPress={() => router.push('/(auth)/login')}
                  style={{
                    backgroundColor: colors.oxygen,
                    borderRadius: 12,
                    paddingHorizontal: 16,
                    paddingVertical: 10,
                    shadowColor: colors.oxygen,
                    shadowOffset: { width: 0, height: 4 },
                    shadowOpacity: 0.3,
                    shadowRadius: 8,
                  }}
                >
                  <Text style={{ color: 'white', fontWeight: '600', fontSize: 14 }}>
                    {t('auth.signIn')}
                  </Text>
                </Pressable>
              )}
            </View>

            {/* Stats */}
            <View style={{
              flexDirection: 'row',
              borderTopWidth: 1,
              borderTopColor: colors.glassBorder,
              paddingTop: 20,
            }}>
              <View style={{ flex: 1, alignItems: 'center' }}>
                <Text style={{ fontSize: 24, fontWeight: '800', color: colors.oxygen }}>24</Text>
                <Text style={{ color: colors.inkSecondary, fontSize: 12, marginTop: 2, fontWeight: '500' }}>
                  {t('profile.scans')}
                </Text>
              </View>
              <View style={{ width: 1, backgroundColor: colors.glassBorder }} />
              <View style={{ flex: 1, alignItems: 'center' }}>
                <Text style={{ fontSize: 24, fontWeight: '800', color: colors.safe }}>18</Text>
                <Text style={{ color: colors.inkSecondary, fontSize: 12, marginTop: 2, fontWeight: '500' }}>
                  {t('profile.toxinsAvoided')}
                </Text>
              </View>
              <View style={{ width: 1, backgroundColor: colors.glassBorder }} />
              <View style={{ flex: 1, alignItems: 'center' }}>
                <Text style={{ fontSize: 24, fontWeight: '800', color: colors.caution }}>5</Text>
                <Text style={{ color: colors.inkSecondary, fontSize: 12, marginTop: 2, fontWeight: '500' }}>
                  {t('profile.dayStreak')}
                </Text>
              </View>
            </View>
          </View>
        </View>

        {/* Premium Banner */}
        <View style={{ paddingHorizontal: 24, marginBottom: 24 }}>
          <Pressable style={{
            backgroundColor: colors.oxygen,
            borderRadius: 24,
            padding: 20,
            flexDirection: 'row',
            alignItems: 'center',
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}>
            <View style={{ flex: 1 }}>
              <Text style={{ color: 'white', fontWeight: '800', fontSize: 18 }}>{t('profile.goPremium')}</Text>
              <Text style={{ color: 'rgba(255, 255, 255, 0.8)', fontSize: 14, marginTop: 4, lineHeight: 20 }}>
                {t('profile.premiumDesc')}
              </Text>
            </View>
            <View style={{
              backgroundColor: 'rgba(255, 255, 255, 0.2)',
              borderRadius: 14,
              padding: 10,
            }}>
              <Ionicons name="arrow-forward" size={24} color="white" />
            </View>
          </Pressable>
        </View>

        {/* Menu Items */}
        <View style={{ paddingHorizontal: 24 }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            overflow: 'hidden',
            borderWidth: 1,
            borderColor: colors.glassBorder,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04,
            shadowRadius: 12,
          }}>
            {menuItems.map((item, index) => (
              <Pressable
                key={item.title}
                onPress={item.onPress}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  padding: 16,
                  borderBottomWidth: index < menuItems.length - 1 ? 1 : 0,
                  borderBottomColor: colors.glassBorder,
                }}
              >
                <View style={{
                  width: 40,
                  height: 40,
                  backgroundColor: colors.canvas,
                  borderRadius: 12,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}>
                  <Ionicons name={item.icon} size={20} color={colors.ink} />
                </View>
                <View style={{ flex: 1, marginLeft: 14 }}>
                  <Text style={{ color: colors.ink, fontWeight: '600', fontSize: 15 }}>
                    {item.title}
                  </Text>
                  {item.subtitle && (
                    <Text style={{ color: colors.inkSecondary, fontSize: 13, marginTop: 2 }}>
                      {item.subtitle}
                    </Text>
                  )}
                </View>
                {item.badge && (
                  <View style={{
                    backgroundColor: colors.oxygenGlow,
                    borderRadius: 8,
                    paddingHorizontal: 10,
                    paddingVertical: 4,
                    marginRight: 8,
                  }}>
                    <Text style={{ color: colors.oxygen, fontSize: 13, fontWeight: '600' }}>
                      {item.badge}
                    </Text>
                  </View>
                )}
                <Ionicons name="chevron-forward" size={20} color={colors.inkMuted} />
              </Pressable>
            ))}
          </View>
        </View>

        {/* Debug Section */}
        <View style={{ paddingHorizontal: 24, marginTop: 24 }}>
          <Pressable
            onPress={handleExportLogs}
            style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 16,
              padding: 16,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              borderWidth: 1,
              borderColor: colors.glassBorder,
            }}
          >
            <Ionicons name="bug-outline" size={20} color={colors.inkSecondary} style={{ marginRight: 8 }} />
            <Text style={{ color: colors.inkSecondary, fontWeight: '600', fontSize: 14 }}>
              {t('profile.exportLogs')}
            </Text>
          </Pressable>
        </View>

        {/* App Version */}
        <View style={{ paddingHorizontal: 24, marginTop: 16, alignItems: 'center' }}>
          <Text style={{ color: colors.inkMuted, fontSize: 13, fontWeight: '500' }}>
            {t('profile.version', { version: '1.0.0' })}
          </Text>
        </View>
      </ScrollView>

      {/* Language Picker Modal */}
      <Modal
        visible={showLanguagePicker}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setShowLanguagePicker(false)}
      >
        <View style={{ flex: 1, justifyContent: 'flex-end', backgroundColor: 'rgba(0,0,0,0.4)' }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderTopLeftRadius: 24,
            borderTopRightRadius: 24,
            paddingTop: 16,
            paddingBottom: 40,
            paddingHorizontal: 24,
          }}>
            {/* Header */}
            <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 }}>
              <Text style={{ fontSize: 20, fontWeight: '800', color: colors.ink }}>
                {t('language.title')}
              </Text>
              <Pressable onPress={() => setShowLanguagePicker(false)}>
                <Ionicons name="close" size={24} color={colors.inkSecondary} />
              </Pressable>
            </View>

            {/* Language Options */}
            {SUPPORTED_LANGUAGES.map((lang) => (
              <Pressable
                key={lang.code}
                onPress={() => { setLanguage(lang.code); setShowLanguagePicker(false); }}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  paddingVertical: 14,
                  borderBottomWidth: 1,
                  borderBottomColor: colors.glassBorder,
                }}
              >
                <View style={{ flex: 1 }}>
                  <Text style={{ fontSize: 16, fontWeight: '600', color: colors.ink }}>{lang.label}</Text>
                  <Text style={{ fontSize: 13, color: colors.inkSecondary, marginTop: 2 }}>{lang.nativeLabel}</Text>
                </View>
                {language === lang.code && (
                  <Ionicons name="checkmark-circle" size={24} color={colors.oxygen} />
                )}
              </Pressable>
            ))}
          </View>
        </View>
      </Modal>
    </SafeAreaView>
  );
}
