import { useState, useRef, useCallback } from 'react';
import { View, Text, Pressable, ActivityIndicator, Animated, Alert, Modal, TextInput, KeyboardAvoidingView, Platform } from 'react-native';
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
import { useCreditStore } from '@/stores/useSubscriptionStore';
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

  const { preferredStore } = usePreferencesStore();

  const [scanStage, setScanStage] = useState<ScanStage>('idle');
  const [scanError, setScanError] = useState<string | null>(null);
  const [quotaModalVisible, setQuotaModalVisible] = useState(false);
  const [showPermissionPrompt, setShowPermissionPrompt] = useState(false);

  // Product info step (between OCR and analysis)
  const [productInfoVisible, setProductInfoVisible] = useState(false);
  const [pendingOcrResult, setPendingOcrResult] = useState<any>(null);
  const [pendingPhoto, setPendingPhoto] = useState<any>(null);
  const [productNameInput, setProductNameInput] = useState('');
  const [brandInput, setBrandInput] = useState('');

  const pulseAnim = useRef(new Animated.Value(1)).current;

  const { setCurrentResult, setError, setImageUri } = useScanStore();
  const isCapturingRef = useRef(false);

  const isProcessing = scanStage !== 'idle' && scanStage !== 'error';

  // Reset state when screen is focused; show camera permission prompt if not yet requested
  useFocusEffect(
    useCallback(() => {
      setScanStage('idle');
      setScanError(null);
      isCapturingRef.current = false;
      pulseAnim.setValue(1);
      ImagePicker.getCameraPermissionsAsync().then(({ status }) => {
        if (status === 'undetermined') {
          setShowPermissionPrompt(true);
        }
      });
    }, [pulseAnim])
  );

  const handlePermissionContinue = async () => {
    await ImagePicker.requestCameraPermissionsAsync();
    setShowPermissionPrompt(false);
  };

  // Check credits before opening camera or describe screen
  const handleQuotaCheck = (): boolean => {
    const { credits } = useCreditStore.getState();
    if (credits <= 0) {
      setQuotaModalVisible(true);
      return true; // no credits
    }
    return false; // has credits
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

  const runAnalysis = async (ocrResult: any, photo: any, productNameOverride?: string, brandOverride?: string) => {
    setScanStage('analyzing');

    const pulse = Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, { toValue: 1.03, duration: 600, useNativeDriver: true }),
        Animated.timing(pulseAnim, { toValue: 1, duration: 600, useNativeDriver: true }),
      ])
    );
    pulse.start();

    try {
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
        productName: productNameOverride?.trim() || undefined,
        brand: brandOverride?.trim() || undefined,
      });

      console.log('Analysis complete:', analysisResult.productName, '- Score:', analysisResult.score);

      pulse.stop();
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
      setCurrentResult(analysisResult);
      useCreditStore.getState().decrementCredit();

      router.push('/result/scan');
    } catch (error) {
      pulse.stop();
      console.error('Scan failed:', error);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);

      if (isQuotaExceededError(error)) {
        setScanStage('idle');
        setQuotaModalVisible(true);
        useCreditStore.getState().refreshCredits();
      } else {
        setScanStage('error');
        const msg = error instanceof Error ? error.message : 'Scan failed';
        setScanError(msg);
        setError(msg);
        setTimeout(() => {
          setScanStage('idle');
          setScanError(null);
        }, 3000);
      }
    } finally {
      isCapturingRef.current = false;
    }
  };

  const handleProductInfoConfirm = () => {
    setProductInfoVisible(false);
    if (pendingOcrResult && pendingPhoto) {
      runAnalysis(pendingOcrResult, pendingPhoto, productNameInput, brandInput);
    }
  };

  const handleProductInfoSkip = () => {
    setProductInfoVisible(false);
    if (pendingOcrResult && pendingPhoto) {
      runAnalysis(pendingOcrResult, pendingPhoto);
    }
  };

  const handleProductInfoDismiss = () => {
    setProductInfoVisible(false);
    isCapturingRef.current = false;
    setScanStage('idle');
  };

  // Open native camera and process the photo
  const handleScan = async () => {
    if (isCapturingRef.current || isProcessing) return;
    if (requireAuth()) return;

    isCapturingRef.current = true;
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);

    const exceeded = handleQuotaCheck();
    if (exceeded) {
      isCapturingRef.current = false;
      return;
    }

    setScanStage('capturing');
    setScanError(null);
    setError(null);

    try {
      const { status } = await ImagePicker.requestCameraPermissionsAsync();
      if (status !== 'granted') {
        setScanStage('error');
        setScanError(t('scan.cameraPermissionDenied', 'Camera permission is required to scan products.'));
        isCapturingRef.current = false;
        return;
      }

      const result = await ImagePicker.launchCameraAsync({
        mediaTypes: ['images'],
        quality: 0.8,
        base64: true,
        allowsEditing: false,
      });

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

      // Start pulse for reading stage
      const pulse = Animated.loop(
        Animated.sequence([
          Animated.timing(pulseAnim, { toValue: 1.03, duration: 600, useNativeDriver: true }),
          Animated.timing(pulseAnim, { toValue: 1, duration: 600, useNativeDriver: true }),
        ])
      );
      pulse.start();
      setScanStage('reading');

      const ocrResult = await processImage(photo.uri);
      pulse.stop();
      pulseAnim.setValue(1);

      // Store pending data and show product info sheet
      setPendingOcrResult(ocrResult);
      setPendingPhoto(photo);
      setProductNameInput('');
      setBrandInput('');
      setScanStage('idle');
      setProductInfoVisible(true);
      // Note: isCapturingRef stays true until analysis completes or user dismisses
    } catch (error) {
      console.error('Scan failed:', error);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);
      setScanStage('error');
      const msg = error instanceof Error ? error.message : 'Scan failed';
      setScanError(msg);
      setError(msg);
      isCapturingRef.current = false;
      setTimeout(() => {
        setScanStage('idle');
        setScanError(null);
      }, 3000);
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
            const exceeded = handleQuotaCheck();
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

      {/* Product Info Bottom Sheet */}
      <Modal
        visible={productInfoVisible}
        transparent
        animationType="slide"
        onRequestClose={handleProductInfoDismiss}
      >
        <KeyboardAvoidingView
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
          style={{ flex: 1, justifyContent: 'flex-end' }}
        >
          <Pressable
            style={{ flex: 1 }}
            onPress={handleProductInfoDismiss}
          />
          <View style={{
            backgroundColor: colors.glassSolid,
            borderTopLeftRadius: 32,
            borderTopRightRadius: 32,
            padding: 28,
            paddingBottom: 40,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: -4 },
            shadowOpacity: 0.1,
            shadowRadius: 20,
          }}>
            {/* Handle */}
            <View style={{
              width: 40, height: 4, borderRadius: 2,
              backgroundColor: 'rgba(0,0,0,0.15)',
              alignSelf: 'center', marginBottom: 24,
            }} />

            <Text style={{ fontSize: 20, fontWeight: '800', color: colors.ink, marginBottom: 6 }}>
              What product is this?
            </Text>
            <Text style={{ fontSize: 14, color: colors.inkSecondary, marginBottom: 24, lineHeight: 22 }}>
              We&apos;ll analyze based on the ingredients regardless — but knowing the product name helps us recommend swaps that are actually the same type of product, not just something with similar ingredients.
            </Text>

            {/* Product Name */}
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8, textTransform: 'uppercase', letterSpacing: 0.5 }}>
              Product Name
            </Text>
            <TextInput
              value={productNameInput}
              onChangeText={setProductNameInput}
              placeholder="e.g. Dawn Ultra Dish Soap"
              placeholderTextColor={colors.inkSecondary}
              style={{
                backgroundColor: 'white',
                borderRadius: 14,
                padding: 16,
                fontSize: 16,
                color: colors.ink,
                marginBottom: 16,
                borderWidth: 1.5,
                borderColor: 'rgba(0,0,0,0.08)',
              }}
              returnKeyType="next"
              autoCapitalize="words"
            />

            {/* Brand */}
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 8, textTransform: 'uppercase', letterSpacing: 0.5 }}>
              Brand
            </Text>
            <TextInput
              value={brandInput}
              onChangeText={setBrandInput}
              placeholder="e.g. Procter & Gamble"
              placeholderTextColor={colors.inkSecondary}
              style={{
                backgroundColor: 'white',
                borderRadius: 14,
                padding: 16,
                fontSize: 16,
                color: colors.ink,
                marginBottom: 28,
                borderWidth: 1.5,
                borderColor: 'rgba(0,0,0,0.08)',
              }}
              returnKeyType="done"
              onSubmitEditing={handleProductInfoConfirm}
              autoCapitalize="words"
            />

            {/* Buttons */}
            <Pressable
              onPress={handleProductInfoConfirm}
              style={{
                backgroundColor: colors.oxygen,
                borderRadius: 16,
                paddingVertical: 18,
                alignItems: 'center',
                marginBottom: 12,
                shadowColor: colors.oxygen,
                shadowOffset: { width: 0, height: 6 },
                shadowOpacity: 0.35,
                shadowRadius: 12,
              }}
            >
              <Text style={{ color: 'white', fontWeight: '800', fontSize: 17 }}>Analyze →</Text>
            </Pressable>

            <Pressable
              onPress={handleProductInfoSkip}
              style={{ paddingVertical: 14, alignItems: 'center' }}
            >
              <Text style={{ color: colors.inkSecondary, fontWeight: '600', fontSize: 15 }}>
                Skip
              </Text>
            </Pressable>
          </View>
        </KeyboardAvoidingView>
      </Modal>

      <QuotaExceededModal
        visible={quotaModalVisible}
        onClose={() => setQuotaModalVisible(false)}
      />

      {/* Camera permission pre-prompt (shown before OS dialog, per App Store guidelines) */}
      {showPermissionPrompt && (
        <View style={{
          position: 'absolute',
          top: 0, left: 0, right: 0, bottom: 0,
          backgroundColor: colors.canvas,
          alignItems: 'center',
          justifyContent: 'center',
          paddingHorizontal: 32,
          zIndex: 200,
        }}>
          <View style={{
            width: 96,
            height: 96,
            borderRadius: 32,
            backgroundColor: colors.oxygenGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 28,
          }}>
            <Ionicons name="camera-outline" size={48} color={colors.oxygen} />
          </View>
          <Text style={{ fontSize: 26, fontWeight: '800', color: colors.ink, textAlign: 'center', marginBottom: 16 }}>
            {t('scan.cameraPermTitle')}
          </Text>
          <Text style={{ fontSize: 15, color: colors.inkSecondary, textAlign: 'center', lineHeight: 24, marginBottom: 40 }}>
            {t('scan.cameraPermDesc')}
          </Text>
          <Pressable
            onPress={handlePermissionContinue}
            style={{
              backgroundColor: colors.oxygen,
              borderRadius: 16,
              paddingVertical: 18,
              alignSelf: 'stretch',
              alignItems: 'center',
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 8 },
              shadowOpacity: 0.35,
              shadowRadius: 16,
            }}
          >
            <Text style={{ color: 'white', fontWeight: '800', fontSize: 18 }}>
              {t('scan.cameraPermContinue')}
            </Text>
          </Pressable>
        </View>
      )}
    </SafeAreaView>
  );
}
