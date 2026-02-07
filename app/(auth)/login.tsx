import { useState } from 'react';
import { View, Text, TextInput, Pressable, ActivityIndicator, KeyboardAvoidingView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { useAuthStore } from '@/stores/useAuthStore';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  error: '#EF4444',
};

export default function LoginScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const { signIn, isLoading } = useAuthStore();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [showPassword, setShowPassword] = useState(false);

  const handleSignIn = async () => {
    setError(null);

    if (!email.trim()) {
      setError(t('auth.emailRequired'));
      return;
    }
    if (!password) {
      setError(t('auth.passwordRequired'));
      return;
    }

    const result = await signIn(email.trim(), password);
    if (result.error) {
      setError(t('auth.signInError'));
    } else {
      router.back();
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      <KeyboardAvoidingView
        style={{ flex: 1 }}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        <View style={{ flex: 1, paddingHorizontal: 24, justifyContent: 'center' }}>
          {/* Back button */}
          <Pressable
            onPress={() => router.back()}
            style={{ position: 'absolute', top: 16, left: 24, zIndex: 10 }}
          >
            <View style={{
              width: 44, height: 44, borderRadius: 14,
              backgroundColor: colors.glassSolid, borderWidth: 1,
              borderColor: colors.glassBorder,
              alignItems: 'center', justifyContent: 'center',
            }}>
              <Ionicons name="arrow-back" size={24} color={colors.ink} />
            </View>
          </Pressable>

          {/* Logo/Title */}
          <View style={{ alignItems: 'center', marginBottom: 40 }}>
            <View style={{
              width: 80, height: 80, borderRadius: 28,
              backgroundColor: colors.oxygenGlow,
              alignItems: 'center', justifyContent: 'center', marginBottom: 20,
            }}>
              <Ionicons name="shield-checkmark" size={40} color={colors.oxygen} />
            </View>
            <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>
              {t('auth.signIn')}
            </Text>
          </View>

          {/* Form */}
          <View style={{
            backgroundColor: colors.glassSolid, borderRadius: 24, padding: 24,
            borderWidth: 1, borderColor: colors.glassBorder,
            shadowColor: '#000', shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04, shadowRadius: 12,
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
                paddingVertical: 14, fontSize: 16, color: colors.ink, marginBottom: 16,
              }}
              placeholder={t('auth.email')}
              placeholderTextColor={colors.inkMuted}
              value={email}
              onChangeText={setEmail}
              autoCapitalize="none"
              keyboardType="email-address"
              autoCorrect={false}
            />

            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8 }}>
              {t('auth.password')}
            </Text>
            <View style={{ flexDirection: 'row', alignItems: 'center', backgroundColor: colors.canvas, borderRadius: 14, marginBottom: 24 }}>
              <TextInput
                style={{
                  flex: 1, paddingHorizontal: 16, paddingVertical: 14,
                  fontSize: 16, color: colors.ink,
                }}
                placeholder={t('auth.password')}
                placeholderTextColor={colors.inkMuted}
                value={password}
                onChangeText={setPassword}
                secureTextEntry={!showPassword}
              />
              <Pressable onPress={() => setShowPassword(!showPassword)} style={{ paddingRight: 16 }}>
                <Ionicons name={showPassword ? 'eye-off' : 'eye'} size={22} color={colors.inkMuted} />
              </Pressable>
            </View>

            <Pressable
              onPress={handleSignIn}
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
                  {t('auth.signIn')}
                </Text>
              )}
            </Pressable>
          </View>

          {/* Sign Up link */}
          <View style={{ flexDirection: 'row', justifyContent: 'center', marginTop: 24 }}>
            <Text style={{ color: colors.inkSecondary, fontSize: 15 }}>
              {t('auth.noAccount')}{' '}
            </Text>
            <Pressable onPress={() => router.replace('/(auth)/signup')}>
              <Text style={{ color: colors.oxygen, fontWeight: '700', fontSize: 15 }}>
                {t('auth.signUp')}
              </Text>
            </Pressable>
          </View>
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
