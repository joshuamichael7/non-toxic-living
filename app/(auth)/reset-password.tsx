import { useState, useEffect, useRef } from 'react';
import { View, Text, TextInput, Pressable, ActivityIndicator, KeyboardAvoidingView, Platform, Keyboard, TouchableWithoutFeedback } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Linking from 'expo-linking';

import { consumeRecoveryToken } from '@/lib/recoverySession';

const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!;

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

  // Holds the raw access token from the recovery deep link.
  // We bypass supabase.auth entirely to avoid its internal async lock, which
  // can hang indefinitely when /auth/v1/user is slow and corrupt auth state.
  const recoveryTokenRef = useRef<string | null>(null);

  useEffect(() => {
    console.log('[ResetPassword] useEffect mounted');
    let resolved = false;

    function markReady(token: string) {
      if (!resolved) {
        resolved = true;
        recoveryTokenRef.current = token;
        console.log('[ResetPassword] markReady — token obtained, showing form');
        setSessionReady(true);
      }
    }

    function parseRecoveryToken(url: string): string | null {
      const fragment = url.split('#')[1];
      if (!fragment) return null;
      const params = new URLSearchParams(fragment);
      const type = params.get('type');
      const at = params.get('access_token');
      console.log('[ResetPassword] parseRecoveryToken: type=', type, 'hasToken=', !!at);
      return (type === 'recovery' && at) ? at : null;
    }

    // 1. Warm-start: token stored by handleAuthDeepLink in _layout.tsx before
    //    this screen mounted (Linking event fires before the screen renders).
    const stored = consumeRecoveryToken();
    if (stored) {
      console.log('[ResetPassword] got token from store (warm-start)');
      markReady(stored);
    }

    // 2. Cold-start: app was opened by the deep link; parse the launch URL.
    if (!resolved) {
      Linking.getInitialURL().then((url) => {
        console.log('[ResetPassword] getInitialURL:', url ? url.substring(0, 80) : 'null');
        if (!url) return;
        const token = parseRecoveryToken(url);
        if (token) markReady(token);
      });
    }

    // 3. Edge case: deep link fires while screen is already open (e.g. user
    //    requests a second reset without leaving the screen).
    const linkSub = Linking.addEventListener('url', ({ url }) => {
      console.log('[ResetPassword] Linking url event:', url.substring(0, 80));
      const token = parseRecoveryToken(url);
      if (token) markReady(token);
    });

    // Show error after 15s instead of spinning forever
    const timeout = setTimeout(() => {
      if (!resolved) {
        console.log('[ResetPassword] timeout — no recovery token received');
        setError('Reset link expired or invalid. Please request a new one.');
      }
    }, 15000);

    return () => {
      linkSub.remove();
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

    const token = recoveryTokenRef.current;
    if (!token) {
      setError('Session expired. Please request a new reset link.');
      return;
    }

    setIsLoading(true);
    try {
      // Use a raw fetch with the recovery access token instead of going through
      // supabase.auth.updateUser(), which acquires the internal JS lock.
      // That lock can be held indefinitely by the setSession call that was made
      // earlier, deadlocking all subsequent auth operations.
      console.log('[ResetPassword] calling PUT /auth/v1/user directly...');
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 15000);

      const response = await fetch(`${supabaseUrl}/auth/v1/user`, {
        method: 'PUT',
        headers: {
          'Authorization': `Bearer ${token}`,
          'apikey': supabaseAnonKey,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ password }),
        signal: controller.signal,
      });
      clearTimeout(timeoutId);

      console.log('[ResetPassword] PUT /auth/v1/user status:', response.status);

      if (response.ok) {
        console.log('[ResetPassword] password updated successfully');
        setDone(true);
      } else {
        const errData = await response.json().catch(() => ({}));
        console.log('[ResetPassword] error response:', errData);
        setError(errData.msg || errData.message || `Update failed (${response.status}). Please try again.`);
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
                <Text style={{ fontSize: 14, color: colors.inkSecondary, textAlign: 'center' }}>
                  Please sign in with your new password.
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
