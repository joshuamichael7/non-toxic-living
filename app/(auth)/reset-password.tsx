import { useState, useEffect } from 'react';
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

export default function ResetPasswordScreen() {
  const { t } = useTranslation();
  const router = useRouter();

  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [sessionReady, setSessionReady] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState(false);

  // Wait for the recovery session to be established by _layout.tsx's handleAuthDeepLink.
  // Use onAuthStateChange so we react immediately when setSession fires, rather than
  // awaiting getSession() which can hang if no session exists yet.
  useEffect(() => {
    console.log('[ResetPassword] useEffect mounted');
    let resolved = false;

    function markReady() {
      if (!resolved) {
        resolved = true;
        setSessionReady(true);
      }
    }

    // React to any auth event that provides a session — covers:
    // SIGNED_IN (warm start, deep link fires while app is open)
    // PASSWORD_RECOVERY (Supabase-specific recovery event)
    // INITIAL_SESSION (cold start — subscriber fires immediately with existing session)
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      console.log('[ResetPassword] onAuthStateChange:', event, session?.user?.email ?? 'no session');
      if (session) {
        markReady();
      }
    });

    // Also check immediately in case setSession already ran before this screen mounted
    supabase.auth.getSession().then(({ data: { session } }) => {
      console.log('[ResetPassword] getSession on mount:', session?.user?.email ?? 'no session');
      if (session) markReady();
    }).catch((e) => console.log('[ResetPassword] getSession error:', e));

    // Show an error after 15s instead of spinning forever
    const timeout = setTimeout(() => {
      if (!resolved) {
        setError('Reset link expired or invalid. Please request a new one.');
      }
    }, 15000);

    return () => {
      subscription.unsubscribe();
      clearTimeout(timeout);
    };
  }, []);

  const handleReset = async () => {
    setError(null);

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

    setIsLoading(true);
    try {
      console.log('[ResetPassword] calling updateUser...');
      const { data, error: err } = await supabase.auth.updateUser({ password });
      console.log('[ResetPassword] updateUser done | error:', err?.message ?? 'none | user:', data?.user?.email ?? 'none');

      if (err) {
        setError(err.message);
      } else {
        setDone(true);
      }
    } catch (e: any) {
      console.log('[ResetPassword] THREW:', e?.name, e?.message ?? e);
      const msg = e?.name === 'AbortError'
        ? 'Request timed out. Please check your connection and try again.'
        : (e?.message ?? 'Something went wrong. Please try again.');
      setError(msg);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      <KeyboardAvoidingView style={{ flex: 1 }} behavior={Platform.OS === 'ios' ? 'padding' : 'height'}>
        <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
          <View style={{ flex: 1, paddingHorizontal: 24, justifyContent: 'center' }}>
            <View style={{ alignItems: 'center', marginBottom: 40 }}>
              <View style={{
                width: 80, height: 80, borderRadius: 28,
                backgroundColor: colors.oxygenGlow,
                alignItems: 'center', justifyContent: 'center', marginBottom: 20,
              }}>
                <Ionicons name="lock-closed" size={40} color={colors.oxygen} />
              </View>
              <Text style={{ fontSize: 28, fontWeight: '800', color: colors.ink }}>
                {t('auth.setNewPassword')}
              </Text>
              <Text style={{ fontSize: 15, color: colors.inkSecondary, textAlign: 'center', marginTop: 8 }}>
                {t('auth.setNewPasswordDesc')}
              </Text>
            </View>

            {done ? (
              <View style={{
                backgroundColor: colors.safeLight, borderRadius: 20, padding: 24,
                alignItems: 'center', gap: 12,
              }}>
                <Ionicons name="checkmark-circle" size={48} color={colors.safe} />
                <Text style={{ fontSize: 17, fontWeight: '700', color: colors.safe, textAlign: 'center' }}>
                  {t('auth.passwordUpdated')}
                </Text>
                <Pressable
                  onPress={() => router.replace('/(tabs)')}
                  style={{
                    marginTop: 8, backgroundColor: colors.oxygen, borderRadius: 14,
                    paddingVertical: 14, paddingHorizontal: 32,
                  }}
                >
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 15 }}>
                    {t('auth.continue')}
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

                {!sessionReady && !error && (
                  <View style={{ alignItems: 'center', paddingVertical: 16 }}>
                    <ActivityIndicator color={colors.oxygen} />
                  </View>
                )}

                {sessionReady && (
                  <>
                    <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8 }}>
                      {t('auth.newPassword')}
                    </Text>
                    <View style={{ flexDirection: 'row', alignItems: 'center', backgroundColor: colors.canvas, borderRadius: 14, marginBottom: 16 }}>
                      <TextInput
                        style={{ flex: 1, paddingHorizontal: 16, paddingVertical: 14, fontSize: 16, color: colors.ink }}
                        placeholder={t('auth.newPassword')}
                        placeholderTextColor={colors.inkMuted}
                        value={password}
                        onChangeText={setPassword}
                        secureTextEntry={!showPassword}
                        autoFocus
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
                          {t('auth.updatePassword')}
                        </Text>
                      )}
                    </Pressable>
                  </>
                )}
              </View>
            )}
          </View>
        </TouchableWithoutFeedback>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
