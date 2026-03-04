import { useState, useRef, useCallback, useMemo } from 'react';
import { View, Text, Pressable, ActivityIndicator, Animated, Alert, TextInput } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useFocusEffect } from '@react-navigation/native';
import * as Haptics from 'expo-haptics';
import * as ImagePicker from 'expo-image-picker';
import { useTranslation } from 'react-i18next';

import { processImage } from '@/services/ocr/OcrPipeline';
import { analyzeIngredients, isQuotaExceededError } from '@/services/api/analyze';
import { useScanStore } from '@/stores/useScanStore';
import { usePreferencesStore } from '@/stores/usePreferencesStore';
import { useAuthStore } from '@/stores/useAuthStore';
import { useSubscriptionStore } from '@/stores/useSubscriptionStore';
import { supabase } from '@/lib/supabase';
import { QuotaExceededModal } from '@/components/ui/QuotaExceededModal';
import { COMMON_STORES } from '@/constants/stores';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  safe: '#10B981',
  error: '#EF4444',
};

const TIER_LIMITS: Record<string, number> = { free: 5, pro: 200, power: 500 };

async function checkQuotaExceeded(): Promise<{ exceeded: boolean; scansUsed: number; scansLimit: number; resetsAt: string }> {
  const userId = useAuthStore.getState().user?.id;
  const tier = useSubscriptionStore.getState().tier;
  if (!userId) return { exceeded: false, scansUsed: 0, scansLimit: 0, resetsAt: '' };

  const limit = TIER_LIMITS[tier] ?? 5;

  const { data } = await (supabase as any)
    .from('profiles')
    .select('scans_this_month, scans_month_reset_at')
    .eq('id', userId)
    .single() as { data: { scans_this_month: number; scans_month_reset_at: string } | null };

  if (!data) return { exceeded: false, scansUsed: 0, scansLimit: limit, resetsAt: '' };

  // If the reset date has passed, the month has rolled over — user has 0 scans used
  const resetAt = new Date(data.scans_month_reset_at);
  if (resetAt < new Date()) {
    return { exceeded: false, scansUsed: 0, scansLimit: limit, resetsAt: data.scans_month_reset_at };
  }

  const exceeded = (data.scans_this_month || 0) >= limit;
  return { exceeded, scansUsed: data.scans_this_month || 0, scansLimit: limit, resetsAt: data.scans_month_reset_at };
}

type ScanStage = 'idle' | 'capturing' | 'reading' | 'analyzing' | 'error';

export default function ScanScreen() {
  const router = useRouter();
  const { t } = useTranslation();

  const { preferredStore, setPreferredStore } = usePreferencesStore();
  const [showStoreInput, setShowStoreInput] = useState(false);
  const [storeInputValue, setStoreInputValue] = useState('');

  const storeMatches = useMemo(() => {
    if (!storeInputValue.trim()) return COMMON_STORES.slice(0, 6);
    const q = storeInputValue.toLowerCase();
    return COMMON_STORES.filter((s) => s.toLowerCase().includes(q)).slice(0, 6);
  }, [storeInputValue]);

  const handleSelectStore = (store: string) => {
    setPreferredStore(store);
    setShowStoreInput(false);
    setStoreInputValue('');
  };

  const [scanStage, setScanStage] = useState<ScanStage>('idle');
  const [scanError, setScanError] = useState<string | null>(null);
  const [quotaModal, setQuotaModal] = useState<{
    visible: boolean;
    scansUsed: number;
    scansLimit: number;
    resetsAt: string;
  }>({ visible: false, scansUsed: 0, scansLimit: 0, resetsAt: '' });

  const pulseAnim = useRef(new Animated.Value(1)).current;

  const { setCurrentResult, setError, setImageUri } = useScanStore();
  const isCapturingRef = useRef(false);

  const isProcessing = scanStage !== 'idle' && scanStage !== 'error';

  // Reset state when screen is focused
  useFocusEffect(
    useCallback(() => {
      setScanStage('idle');
      setScanError(null);
      isCapturingRef.current = false;
      pulseAnim.setValue(1);
    }, [pulseAnim])
  );

  // Check quota before opening camera or describe screen
  const handleQuotaCheck = async (): Promise<boolean> => {
    try {
      const quota = await checkQuotaExceeded();
      if (quota.exceeded) {
        setQuotaModal({
          visible: true,
          scansUsed: quota.scansUsed,
          scansLimit: quota.scansLimit,
          resetsAt: quota.resetsAt,
        });
        return true; // exceeded
      }
    } catch (err) {
      // If quota check fails, let the server-side check handle it
      console.warn('Client quota check failed, proceeding:', err);
    }
    return false; // not exceeded
  };

  // Prompt guest users to sign up before scanning
  const requireAuth = (): boolean => {
    const currentUser = useAuthStore.getState().user;
    if (currentUser) return false; // authenticated, proceed

    Alert.alert(
      t('scan.signInRequired'),
      t('scan.signInRequiredMessage'),
      [
        { text: t('scan.notNow'), style: 'cancel' },
        { text: t('scan.signUp'), onPress: () => router.push('/(auth)/signup') },
      ],
    );
    return true; // blocked
  };

  // Open native camera and process the photo
  const handleScan = async () => {
    if (isCapturingRef.current || isProcessing) return;
    if (requireAuth()) return;

    isCapturingRef.current = true;
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);

    // Pre-check quota before opening camera
    const exceeded = await handleQuotaCheck();
    if (exceeded) {
      isCapturingRef.current = false;
      return;
    }

    setScanStage('capturing');
    setScanError(null);
    setError(null);

    try {
      // Request camera permission
      const { status } = await ImagePicker.requestCameraPermissionsAsync();
      if (status !== 'granted') {
        setScanStage('error');
        setScanError(t('scan.cameraPermissionDenied', 'Camera permission is required to scan products.'));
        isCapturingRef.current = false;
        return;
      }

      // Open native camera
      const result = await ImagePicker.launchCameraAsync({
        mediaTypes: ['images'],
        quality: 0.8,
        base64: true,
        allowsEditing: false,
      });

      // User cancelled
      if (result.canceled || !result.assets?.[0]) {
        setScanStage('idle');
        isCapturingRef.current = false;
        return;
      }

      const photo = result.assets[0];
      if (!photo.uri || !photo.base64) {
        throw new Error('Failed to capture photo');
      }

      setImageUri(photo.uri);
      console.log('Photo captured:', {
        width: photo.width,
        height: photo.height,
        base64Size: `${(photo.base64.length / 1024).toFixed(0)}KB`,
      });

      // Start pulse animation for processing states
      const pulse = Animated.loop(
        Animated.sequence([
          Animated.timing(pulseAnim, { toValue: 1.03, duration: 600, useNativeDriver: true }),
          Animated.timing(pulseAnim, { toValue: 1, duration: 600, useNativeDriver: true }),
        ])
      );
      pulse.start();

      setScanStage('reading');

      // Run OCR pipeline on device
      const ocrResult = await processImage(photo.uri);
      console.log('OCR pipeline result:', {
        source: ocrResult.ocrResult.source,
        textLength: ocrResult.ocrResult.text.length,
        shouldSendImage: ocrResult.shouldSendImage,
        stepsCount: ocrResult.clientSteps.length,
      });

      setScanStage('analyzing');

      // Send to Edge Function for analysis
      const language = usePreferencesStore.getState().language;
      const userId = useAuthStore.getState().user?.id;
      const store = usePreferencesStore.getState().preferredStore;
      const analysisResult = await analyzeIngredients({
        text: ocrResult.ocrResult.text || undefined,
        imageBase64: ocrResult.shouldSendImage ? photo.base64 : undefined,
        ocrSource: ocrResult.ocrResult.source,
        ocrConfidence: ocrResult.ocrResult.confidence,
        clientSteps: ocrResult.clientSteps,
        language,
        userId,
        store: store ?? undefined,
      });

      console.log('Analysis complete:', analysisResult.productName, '- Score:', analysisResult.score);

      pulse.stop();
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
      setCurrentResult(analysisResult);

      router.push('/result/scan');
    } catch (error) {
      console.error('Scan failed:', error);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);

      if (isQuotaExceededError(error)) {
        setScanStage('idle');
        setQuotaModal({
          visible: true,
          scansUsed: error.scansUsed,
          scansLimit: error.scansLimit,
          resetsAt: error.resetsAt,
        });
      } else {
        setScanStage('error');
        const msg = error instanceof Error ? error.message : 'Scan failed';
        setScanError(msg);
        setError(msg);

        // Auto-reset after 3 seconds
        setTimeout(() => {
          setScanStage('idle');
          setScanError(null);
        }, 3000);
      }
    } finally {
      isCapturingRef.current = false;
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      {/* Processing Overlay */}
      {isProcessing && scanStage !== 'capturing' && (
        <View style={{
          position: 'absolute',
          top: 0, left: 0, right: 0, bottom: 0,
          backgroundColor: 'rgba(0, 0, 0, 0.6)',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 100,
        }}>
          <Animated.View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            padding: 32,
            alignItems: 'center',
            marginHorizontal: 40,
            transform: [{ scale: pulseAnim }],
          }}>
            <ActivityIndicator size="large" color={colors.oxygen} style={{ marginBottom: 16 }} />
            <Text style={{ color: colors.ink, fontWeight: '700', fontSize: 18 }}>
              {scanStage === 'reading' && t('scan.reading')}
              {scanStage === 'analyzing' && t('scan.analyzing')}
            </Text>
            <Text style={{ color: colors.inkSecondary, marginTop: 8, fontSize: 14 }}>
              {scanStage === 'reading' && t('scan.extracting')}
              {scanStage === 'analyzing' && t('scan.checking')}
            </Text>
          </Animated.View>
        </View>
      )}

      {/* Error Toast */}
      {scanStage === 'error' && scanError && (
        <View style={{
          position: 'absolute',
          top: 60,
          left: 20,
          right: 20,
          backgroundColor: colors.error,
          borderRadius: 16,
          padding: 16,
          flexDirection: 'row',
          alignItems: 'center',
          zIndex: 100,
        }}>
          <Ionicons name="alert-circle" size={24} color="white" />
          <Text style={{ color: 'white', fontWeight: '600', marginLeft: 12, flex: 1 }}>{scanError}</Text>
          <Pressable onPress={() => { setScanStage('idle'); setScanError(null); }}>
            <Ionicons name="close" size={24} color="white" />
          </Pressable>
        </View>
      )}

      {/* Main Content */}
      <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 24 }}>
        {/* Icon */}
        <View style={{
          width: 120,
          height: 120,
          borderRadius: 40,
          backgroundColor: colors.oxygenGlow,
          alignItems: 'center',
          justifyContent: 'center',
          marginBottom: 32,
        }}>
          <Ionicons name="scan" size={56} color={colors.oxygen} />
        </View>

        {/* Title */}
        <Text style={{
          fontSize: 28,
          fontWeight: '800',
          color: colors.ink,
          textAlign: 'center',
          marginBottom: 12,
        }}>
          {t('scan.title')}
        </Text>

        {/* Subtitle */}
        <Text style={{
          fontSize: 16,
          color: colors.inkSecondary,
          textAlign: 'center',
          lineHeight: 24,
          marginBottom: 24,
          paddingHorizontal: 16,
        }}>
          {t('scan.subtitle')}
        </Text>

        {/* Store chip — optional, persistent */}
        {!showStoreInput ? (
          <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 24 }}>
            {preferredStore ? (
              <>
                <Pressable
                  onPress={() => { setStoreInputValue(preferredStore); setShowStoreInput(true); }}
                  style={{
                    flexDirection: 'row', alignItems: 'center',
                    backgroundColor: colors.oxygenGlow, borderRadius: 20,
                    paddingVertical: 8, paddingHorizontal: 12,
                  }}
                >
                  <Ionicons name="storefront-outline" size={13} color={colors.oxygen} />
                  <Text style={{ fontSize: 13, fontWeight: '600', color: colors.oxygen, marginLeft: 6 }}>
                    {t('store.shoppingAt', { store: preferredStore })}
                  </Text>
                </Pressable>
                <Pressable onPress={() => setPreferredStore(null)} hitSlop={10} style={{ marginLeft: 6 }}>
                  <Ionicons name="close-circle" size={18} color={colors.inkSecondary} />
                </Pressable>
              </>
            ) : (
              <Pressable
                onPress={() => setShowStoreInput(true)}
                style={{ flexDirection: 'row', alignItems: 'center' }}
              >
                <Ionicons name="storefront-outline" size={13} color={colors.inkSecondary} />
                <Text style={{ fontSize: 13, color: colors.inkSecondary, marginLeft: 5 }}>
                  {t('scan.setStore')}
                </Text>
              </Pressable>
            )}
          </View>
        ) : (
          <View style={{
            alignSelf: 'stretch', marginBottom: 16,
            backgroundColor: colors.glassSolid, borderRadius: 16,
            padding: 14, borderWidth: 1, borderColor: colors.oxygen,
          }}>
            <View style={{ flexDirection: 'row', gap: 8 }}>
              <TextInput
                value={storeInputValue}
                onChangeText={setStoreInputValue}
                placeholder={t('store.inputPlaceholder')}
                placeholderTextColor={colors.inkSecondary}
                autoFocus
                returnKeyType="done"
                onSubmitEditing={() => {
                  if (storeInputValue.trim()) handleSelectStore(storeInputValue.trim());
                }}
                style={{
                  flex: 1, backgroundColor: colors.canvas, borderRadius: 10,
                  paddingHorizontal: 12, paddingVertical: 10,
                  fontSize: 14, color: colors.ink,
                  borderWidth: 1, borderColor: colors.glassBorder,
                }}
              />
              <Pressable
                onPress={() => { setShowStoreInput(false); setStoreInputValue(''); }}
                style={{ justifyContent: 'center', paddingHorizontal: 4 }}
                hitSlop={8}
              >
                <Text style={{ fontSize: 13, color: colors.inkSecondary }}>{t('common.cancel')}</Text>
              </Pressable>
            </View>
            {storeMatches.length > 0 && (
              <View style={{ marginTop: 8, gap: 2 }}>
                {storeMatches.map((store) => (
                  <Pressable
                    key={store}
                    onPress={() => handleSelectStore(store)}
                    style={({ pressed }) => ({
                      backgroundColor: pressed ? colors.oxygenGlow : colors.canvas,
                      borderRadius: 8, paddingVertical: 9, paddingHorizontal: 12,
                    })}
                  >
                    <Text style={{ fontSize: 14, color: colors.ink }}>{store}</Text>
                  </Pressable>
                ))}
              </View>
            )}
          </View>
        )}

        {/* Scan Button */}
        <Pressable
          onPress={handleScan}
          disabled={isProcessing}
          style={{
            backgroundColor: colors.oxygen,
            borderRadius: 20,
            paddingVertical: 20,
            alignSelf: 'stretch',
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            opacity: isProcessing ? 0.5 : 1,
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 10 },
            shadowOpacity: 0.4,
            shadowRadius: 20,
          }}
        >
          <Ionicons name="camera" size={26} color="white" style={{ marginRight: 12 }} />
          <Text style={{ color: 'white', fontWeight: '800', fontSize: 20 }}>
            {t('scan.openCamera')}
          </Text>
        </Pressable>

        {/* No-label option */}
        <Pressable
          onPress={async () => {
            if (requireAuth()) return;
            const exceeded = await handleQuotaCheck();
            if (exceeded) return;
            router.push('/describe');
          }}
          style={{
            marginTop: 16,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            alignSelf: 'stretch',
            backgroundColor: colors.glassSolid,
            borderRadius: 16,
            paddingVertical: 14,
            borderWidth: 1.5,
            borderColor: colors.inkSecondary,
          }}
        >
          <Ionicons name="document-text-outline" size={18} color={colors.ink} style={{ marginRight: 8 }} />
          <Text style={{ color: colors.ink, fontWeight: '600', fontSize: 15 }}>
            {t('scan.noLabel')}
          </Text>
          <Ionicons name="chevron-forward" size={16} color={colors.inkSecondary} style={{ marginLeft: 4 }} />
        </Pressable>

        {/* Tip */}
        <Text style={{
          fontSize: 13,
          color: colors.inkSecondary,
          textAlign: 'center',
          marginTop: 24,
          paddingHorizontal: 32,
        }}>
          {t('scan.tip')}
        </Text>
      </View>

      <QuotaExceededModal
        visible={quotaModal.visible}
        onClose={() => setQuotaModal(prev => ({ ...prev, visible: false }))}
        scansUsed={quotaModal.scansUsed}
        scansLimit={quotaModal.scansLimit}
        resetsAt={quotaModal.resetsAt}
      />
    </SafeAreaView>
  );
}
