import { useState, useRef, useCallback } from 'react';
import { View, Text, Pressable, ActivityIndicator, Animated } from 'react-native';
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
import { QuotaExceededModal } from '@/components/ui/QuotaExceededModal';

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

type ScanStage = 'idle' | 'capturing' | 'reading' | 'analyzing' | 'error';

export default function ScanScreen() {
  const router = useRouter();
  const { t } = useTranslation();

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

  // Open native camera and process the photo
  const handleScan = async () => {
    if (isCapturingRef.current || isProcessing) return;

    isCapturingRef.current = true;
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
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
      const analysisResult = await analyzeIngredients({
        text: ocrResult.ocrResult.text || undefined,
        imageBase64: ocrResult.shouldSendImage ? photo.base64 : undefined,
        ocrSource: ocrResult.ocrResult.source,
        ocrConfidence: ocrResult.ocrResult.confidence,
        clientSteps: ocrResult.clientSteps,
        language,
        userId,
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
          marginBottom: 48,
          paddingHorizontal: 16,
        }}>
          {t('scan.subtitle')}
        </Text>

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
          onPress={() => router.push('/describe')}
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
