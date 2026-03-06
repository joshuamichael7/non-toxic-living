import { useState } from 'react';
import { View, Text, TextInput, Pressable, ActivityIndicator, KeyboardAvoidingView, Platform, Keyboard, TouchableWithoutFeedback } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { supabase } from '@/lib/supabase';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  error: '#EF4444',
};

export default function ForgotPasswordScreen() {
  const { t } = useTranslation();
  const router = useRouter();

  const [email, setEmail] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [sent, setSent] = useState(false);

  const handleReset = async () => {
    setError(null);
    if (!email.trim()) {
      setError(t('auth.emailRequired'));
      return;
    }

    setIsLoading(true);
    const { error: err } = await supabase.auth.resetPasswordForEmail(email.trim(), {
      redirectTo: 'nontoxicliving://auth/callback',
    });
    setIsLoading(false);

    if (err) {
      setError(err.message);
    } else {
      setSent(true);
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      <Pressable
        onPress={() => router.back()}
        style={{ position: 'absolute', top: 60, left: 20, zIndex: 10, padding: 8 }}
        hitSlop={12}
      >
        <Ionicons name="arrow-back" size={28} color={colors.inkSecondary} />
      </Pressable>

      <KeyboardAvoidingView style={{ flex: 1 }} behavior={Platform.OS === 'ios' ? 'padding' : 'height'}>
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
          <View style={{ flex: 1, paddingHorizontal: 24, justifyContent: 'center' }}>
            <View style={{ alignItems: 'center', marginBottom: 40 }}>
              <View style={{
                width: 80, height: 80, borderRadius: 28,
                backgroundColor: colors.oxygenGlow,
                alignItems: 'center', justifyContent: 'center', marginBottom: 20,
              }}>
                <Ionicons name="key" size={40} color={colors.oxygen} />
              </View>
              <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>
                {t('auth.forgotPassword')}
              </Text>
              <Text style={{ fontSize: 15, color: colors.inkSecondary, textAlign: 'center', marginTop: 8, lineHeight: 22 }}>
                {t('auth.forgotPasswordDesc')}
              </Text>
            </View>

            {sent ? (
              <View style={{
                backgroundColor: colors.safeLight, borderRadius: 20, padding: 24,
                alignItems: 'center', gap: 12,
              }}>
                <Ionicons name="checkmark-circle" size={48} color={colors.safe} />
                <Text style={{ fontSize: 17, fontWeight: '700', color: colors.safe, textAlign: 'center' }}>
                  {t('auth.resetEmailSent')}
                </Text>
                <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center', lineHeight: 20 }}>
                  {t('auth.resetEmailDesc')}
                </Text>
                <Pressable
                  onPress={() => router.replace('/(auth)/login')}
                  style={{
                    marginTop: 8, backgroundColor: colors.oxygen, borderRadius: 14,
                    paddingVertical: 14, paddingHorizontal: 32,
                  }}
                >
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 15 }}>
                    {t('auth.backToSignIn')}
                  </Text>
                </Pressable>
              </View>
            ) : (
              <View style={{
                backgroundColor: colors.glassSolid, borderRadius: 24, padding: 24,
                borderWidth: 1, borderColor: colors.glassBorder,
              }}>
                {error && (
                  <View style={{
                    backgroundColor: 'rgba(239, 68, 68, 0.1)', borderRadius: 12,
                    padding: 12, marginBottom: 16, flexDirection: 'row', alignItems: 'center',
                  }}>
                    <Ionicons name="alert-circle" size={20} color={colors.error} />
                    <Text style={{ color: colors.error, marginLeft: 8, flex: 1, fontWeight: '500' }}>{error}</Text>
                  </View>
                )}

                <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8 }}>
                  {t('auth.email')}
                </Text>
                <TextInput
                  style={{
                    backgroundColor: colors.canvas, borderRadius: 14, paddingHorizontal: 16,
                    paddingVertical: 14, fontSize: 16, color: colors.ink, marginBottom: 24,
                  }}
                  placeholder={t('auth.email')}
                  placeholderTextColor={colors.inkMuted}
                  value={email}
                  onChangeText={setEmail}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  autoCorrect={false}
                  autoFocus
                />

                <Pressable
                  onPress={handleReset}
                  disabled={isLoading}
                  style={{
                    backgroundColor: colors.oxygen, borderRadius: 16,
                    paddingVertical: 16, alignItems: 'center',
                    opacity: isLoading ? 0.6 : 1,
                    shadowColor: colors.oxygen, shadowOffset: { width: 0, height: 8 },
                    shadowOpacity: 0.3, shadowRadius: 16,
                  }}
                >
                  {isLoading ? (
                    <ActivityIndicator color="white" />
                  ) : (
                    <Text style={{ color: 'white', fontWeight: '700', fontSize: 16 }}>
                      {t('auth.sendResetLink')}
                    </Text>
                  )}
                </Pressable>
              </View>
            )}
          </View>
        </TouchableWithoutFeedback>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
