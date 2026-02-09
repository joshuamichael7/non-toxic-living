import { useState } from 'react';
import { View, Text, TextInput, Pressable, ActivityIndicator, KeyboardAvoidingView, Platform, Keyboard, TouchableWithoutFeedback, ScrollView } from 'react-native';
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
  safe: '#10B981',
};

export default function SignUpScreen() {
  const { t } = useTranslation();
  const router = useRouter();
  const { signUp, isLoading } = useAuthStore();

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

  const handleSignUp = async () => {
    setError(null);

    if (!name.trim()) {
      setError(t('auth.nameRequired', 'Name is required'));
      return;
    }
    if (!email.trim()) {
      setError(t('auth.emailRequired'));
      return;
    }
    if (!password) {
      setError(t('auth.passwordRequired'));
      return;
    }
    if (password.length < 6) {
      setError(t('auth.passwordMinLength'));
      return;
    }
    if (password !== confirmPassword) {
      setError(t('auth.passwordMismatch'));
      return;
    }

    const result = await signUp(email.trim(), password, name.trim());
    if (result.error) {
      setError(t('auth.signUpError'));
    } else {
      setSuccess(true);
    }
  };

  if (success) {
    return (
      <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
        <View style={{ flex: 1, paddingHorizontal: 24, justifyContent: 'center', alignItems: 'center' }}>
          <View style={{
            width: 80, height: 80, borderRadius: 28,
            backgroundColor: 'rgba(16, 185, 129, 0.15)',
            alignItems: 'center', justifyContent: 'center', marginBottom: 20,
          }}>
            <Ionicons name="mail" size={40} color={colors.safe} />
          </View>
          <Text style={{ fontSize: 22, fontWeight: '800', color: colors.ink, textAlign: 'center', marginBottom: 12 }}>
            {t('auth.checkEmail')}
          </Text>
          <Pressable
            onPress={() => router.replace('/(auth)/login')}
            style={{
              backgroundColor: colors.oxygen, borderRadius: 16,
              paddingVertical: 14, paddingHorizontal: 32, marginTop: 24,
            }}
          >
            <Text style={{ color: 'white', fontWeight: '700', fontSize: 16 }}>
              {t('auth.signIn')}
            </Text>
          </Pressable>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      <KeyboardAvoidingView
        style={{ flex: 1 }}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <ScrollView
          contentContainerStyle={{ flexGrow: 1, paddingHorizontal: 24, justifyContent: 'center' }}
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator={false}
        >
          {/* Title */}
          <View style={{ alignItems: 'center', marginBottom: 32 }}>
            <View style={{
              width: 80, height: 80, borderRadius: 28,
              backgroundColor: colors.oxygenGlow,
              alignItems: 'center', justifyContent: 'center', marginBottom: 20,
            }}>
              <Ionicons name="person-add" size={40} color={colors.oxygen} />
            </View>
            <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>
              {t('auth.signUp')}
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
              {t('auth.name', 'Name')}
            </Text>
            <TextInput
              style={{
                backgroundColor: colors.canvas, borderRadius: 14, paddingHorizontal: 16,
                paddingVertical: 14, fontSize: 16, color: colors.ink, marginBottom: 16,
              }}
              placeholder={t('auth.name', 'Name')}
              placeholderTextColor={colors.inkMuted}
              value={name}
              onChangeText={setName}
              autoCapitalize="words"
              autoCorrect={false}
            />

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
            <View style={{ flexDirection: 'row', alignItems: 'center', backgroundColor: colors.canvas, borderRadius: 14, marginBottom: 16 }}>
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

            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8 }}>
              {t('auth.confirmPassword')}
            </Text>
            <TextInput
              style={{
                backgroundColor: colors.canvas, borderRadius: 14, paddingHorizontal: 16,
                paddingVertical: 14, fontSize: 16, color: colors.ink, marginBottom: 24,
              }}
              placeholder={t('auth.confirmPassword')}
              placeholderTextColor={colors.inkMuted}
              value={confirmPassword}
              onChangeText={setConfirmPassword}
              secureTextEntry={!showPassword}
            />

            <Pressable
              onPress={handleSignUp}
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
                  {t('auth.signUp')}
                </Text>
              )}
            </Pressable>
          </View>

          {/* Sign In link */}
          <View style={{ flexDirection: 'row', justifyContent: 'center', marginTop: 24, paddingBottom: 40 }}>
            <Text style={{ color: colors.inkSecondary, fontSize: 15 }}>
              {t('auth.hasAccount')}{' '}
            </Text>
            <Pressable onPress={() => router.replace('/(auth)/login')}>
              <Text style={{ color: colors.oxygen, fontWeight: '700', fontSize: 15 }}>
                {t('auth.signIn')}
              </Text>
            </Pressable>
          </View>
        </ScrollView>
        </TouchableWithoutFeedback>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
