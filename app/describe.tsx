import { useState, useRef } from 'react';
import { View, Text, ScrollView, Pressable, TextInput, ActivityIndicator, Image, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import * as Haptics from 'expo-haptics';
import * as ImagePicker from 'expo-image-picker';
import { useTranslation } from 'react-i18next';

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
  oxygenDeep: '#0284C7',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  error: '#EF4444',
};

const PRODUCT_TYPES = [
  { key: 'food', icon: 'nutrition-outline' as const },
  { key: 'furniture', icon: 'bed-outline' as const },
  { key: 'mattress', icon: 'bed-outline' as const },
  { key: 'clothing', icon: 'shirt-outline' as const },
  { key: 'cookware', icon: 'restaurant-outline' as const },
  { key: 'toys', icon: 'game-controller-outline' as const },
  { key: 'fragrance', icon: 'flame-outline' as const },
  { key: 'paint', icon: 'color-palette-outline' as const },
  { key: 'garden', icon: 'leaf-outline' as const },
  { key: 'pet', icon: 'paw-outline' as const },
  { key: 'storage', icon: 'cube-outline' as const },
  { key: 'household', icon: 'home-outline' as const },
] as const;

export default function DescribeScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const { setCurrentResult, setError } = useScanStore();

  const [selectedType, setSelectedType] = useState<string | null>(null);
  const [brandName, setBrandName] = useState('');
  const [productName, setProductName] = useState('');
  const [materials, setMaterials] = useState('');
  const [photoUri, setPhotoUri] = useState<string | null>(null);
  const [photoBase64, setPhotoBase64] = useState<string | null>(null);
  const [analyzing, setAnalyzing] = useState(false);
  const [validationError, setValidationError] = useState<string | null>(null);
  const [quotaModal, setQuotaModal] = useState<{
    visible: boolean;
    scansUsed: number;
    scansLimit: number;
    resetsAt: string;
  }>({ visible: false, scansUsed: 0, scansLimit: 0, resetsAt: '' });

  const materialsRef = useRef<TextInput>(null);

  const handleAddPhoto = async () => {
    const result = await ImagePicker.launchCameraAsync({
      mediaTypes: ['images'],
      quality: 0.6,
      base64: true,
      allowsEditing: false,
    });

    if (!result.canceled && result.assets?.[0]) {
      setPhotoUri(result.assets[0].uri);
      setPhotoBase64(result.assets[0].base64 || null);
    }
  };

  const handleRemovePhoto = () => {
    setPhotoUri(null);
    setPhotoBase64(null);
  };

  const handleAnalyze = async () => {
    if (!selectedType) {
      setValidationError(t('describe.selectType'));
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Warning);
      return;
    }

    setValidationError(null);
    setAnalyzing(true);
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);

    // Format user inputs into text for the AI
    const parts: string[] = [];
    parts.push(`Product type: ${selectedType}`);
    if (brandName.trim()) parts.push(`Brand: ${brandName.trim()}`);
    if (productName.trim()) parts.push(`Product name: ${productName.trim()}`);
    if (materials.trim()) parts.push(`Materials/composition: ${materials.trim()}`);
    const text = parts.join('\n');

    try {
      const language = usePreferencesStore.getState().language;
      const userId = useAuthStore.getState().user?.id;

      const result = await analyzeIngredients({
        text,
        imageBase64: photoBase64 || undefined,
        ocrSource: 'manual',
        ocrConfidence: 1.0,
        language,
        userId,
        clientSteps: [{
          name: 'Manual Input',
          status: 'success',
          durationMs: 0,
          detail: `User described a ${selectedType} product`,
        }],
      });

      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
      setCurrentResult(result);

      // Reset form
      setSelectedType(null);
      setBrandName('');
      setProductName('');
      setMaterials('');
      setPhotoUri(null);
      setPhotoBase64(null);

      router.replace('/result/scan');
    } catch (error) {
      console.error('Analysis failed:', error);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);

      if (isQuotaExceededError(error)) {
        setQuotaModal({
          visible: true,
          scansUsed: error.scansUsed,
          scansLimit: error.scansLimit,
          resetsAt: error.resetsAt,
        });
      } else {
        const msg = error instanceof Error ? error.message : 'Analysis failed';
        setError(msg);
        Alert.alert(t('common.error'), msg);
      }
    } finally {
      setAnalyzing(false);
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }}>
      {/* Header */}
      <View style={{ flexDirection: 'row', alignItems: 'center', paddingHorizontal: 20, paddingVertical: 16 }}>
        <Pressable onPress={() => router.back()} style={{ marginRight: 16 }}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={{ fontSize: 20, fontWeight: '700', color: colors.ink }}>
          {t('describe.title')}
        </Text>
      </View>

      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingHorizontal: 20, paddingBottom: 120 }}
        showsVerticalScrollIndicator={false}
        keyboardShouldPersistTaps="handled"
      >
        {/* Product Type Picker */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 16,
        }}>
          <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 14 }}>
            {t('describe.productType')}
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={{ gap: 10 }}
          >
            {PRODUCT_TYPES.map((type) => {
              const isSelected = selectedType === type.key;
              return (
                <Pressable
                  key={type.key}
                  onPress={() => {
                    setSelectedType(type.key);
                    setValidationError(null);
                    Haptics.selectionAsync();
                  }}
                  style={{
                    backgroundColor: isSelected ? colors.oxygen : colors.canvas,
                    borderRadius: 14,
                    paddingVertical: 10,
                    paddingHorizontal: 14,
                    flexDirection: 'row',
                    alignItems: 'center',
                    borderWidth: 2,
                    borderColor: isSelected ? colors.oxygen : 'transparent',
                  }}
                >
                  <Ionicons
                    name={type.icon}
                    size={16}
                    color={isSelected ? 'white' : colors.ink}
                    style={{ marginRight: 6 }}
                  />
                  <Text style={{
                    fontSize: 13,
                    fontWeight: '600',
                    color: isSelected ? 'white' : colors.ink,
                  }}>
                    {t(`describe.type.${type.key}`)}
                  </Text>
                </Pressable>
              );
            })}
          </ScrollView>
          {validationError && (
            <Text style={{ color: colors.error, fontSize: 13, marginTop: 10, fontWeight: '500' }}>
              {validationError}
            </Text>
          )}
        </View>

        {/* Brand Input */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 16,
        }}>
          <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 10 }}>
            {t('describe.brand')}
          </Text>
          <TextInput
            value={brandName}
            onChangeText={setBrandName}
            placeholder={t('describe.brandPlaceholder')}
            placeholderTextColor={colors.inkMuted}
            style={{
              backgroundColor: colors.canvas,
              borderRadius: 12,
              padding: 14,
              fontSize: 15,
              color: colors.ink,
            }}
            returnKeyType="next"
          />
        </View>

        {/* Product Name Input */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 16,
        }}>
          <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 10 }}>
            {t('describe.productName')}
          </Text>
          <TextInput
            value={productName}
            onChangeText={setProductName}
            placeholder={t('describe.productNamePlaceholder')}
            placeholderTextColor={colors.inkMuted}
            style={{
              backgroundColor: colors.canvas,
              borderRadius: 12,
              padding: 14,
              fontSize: 15,
              color: colors.ink,
            }}
            returnKeyType="next"
            onSubmitEditing={() => materialsRef.current?.focus()}
          />
        </View>

        {/* Materials TextArea */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 16,
        }}>
          <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 10 }}>
            {t('describe.materials')}
          </Text>
          <TextInput
            ref={materialsRef}
            value={materials}
            onChangeText={setMaterials}
            placeholder={t('describe.materialsPlaceholder')}
            placeholderTextColor={colors.inkMuted}
            multiline
            numberOfLines={4}
            textAlignVertical="top"
            style={{
              backgroundColor: colors.canvas,
              borderRadius: 12,
              padding: 14,
              fontSize: 15,
              color: colors.ink,
              minHeight: 100,
            }}
          />
        </View>

        {/* Photo Section */}
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 20,
          padding: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          marginBottom: 16,
        }}>
          {photoUri ? (
            <View>
              <Image
                source={{ uri: photoUri }}
                style={{ width: '100%', height: 200, borderRadius: 12, marginBottom: 12 }}
                resizeMode="cover"
              />
              <Pressable
                onPress={handleRemovePhoto}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <Ionicons name="trash-outline" size={18} color={colors.error} style={{ marginRight: 6 }} />
                <Text style={{ color: colors.error, fontWeight: '600', fontSize: 14 }}>
                  {t('describe.removePhoto')}
                </Text>
              </Pressable>
            </View>
          ) : (
            <Pressable
              onPress={handleAddPhoto}
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                justifyContent: 'center',
                paddingVertical: 16,
              }}
            >
              <Ionicons name="camera-outline" size={22} color={colors.inkSecondary} style={{ marginRight: 8 }} />
              <Text style={{ color: colors.inkSecondary, fontWeight: '600', fontSize: 15 }}>
                {t('describe.addPhoto')}
              </Text>
            </Pressable>
          )}
        </View>
      </ScrollView>

      {/* Bottom Analyze Button */}
      <View style={{
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        paddingHorizontal: 20,
        paddingBottom: 40,
        paddingTop: 16,
        backgroundColor: colors.canvas,
      }}>
        <Pressable
          onPress={handleAnalyze}
          disabled={analyzing}
          style={{
            backgroundColor: colors.oxygen,
            borderRadius: 20,
            paddingVertical: 18,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            opacity: analyzing ? 0.6 : 1,
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}
        >
          {analyzing ? (
            <ActivityIndicator color="white" style={{ marginRight: 10 }} />
          ) : (
            <Ionicons name="search" size={22} color="white" style={{ marginRight: 10 }} />
          )}
          <Text style={{ color: 'white', fontWeight: '700', fontSize: 18 }}>
            {t('describe.analyze')}
          </Text>
        </Pressable>
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
