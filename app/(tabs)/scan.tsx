import { useState, useRef } from 'react';
import { View, Text, Pressable, StyleSheet } from 'react-native';
import { CameraView, CameraType, useCameraPermissions } from 'expo-camera';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';

export default function ScanScreen() {
  const router = useRouter();
  const cameraRef = useRef<CameraView>(null);
  const [permission, requestPermission] = useCameraPermissions();
  const [isCapturing, setIsCapturing] = useState(false);

  if (!permission) {
    return (
      <View className="flex-1 bg-stone-900 items-center justify-center">
        <Text className="text-white">Loading camera...</Text>
      </View>
    );
  }

  if (!permission.granted) {
    return (
      <SafeAreaView className="flex-1 bg-stone-50 items-center justify-center px-6">
        <View className="bg-white rounded-2xl p-6 items-center shadow-lg">
          <View className="w-16 h-16 bg-primary/10 rounded-full items-center justify-center mb-4">
            <Ionicons name="camera" size={32} color="#059669" />
          </View>
          <Text className="text-xl font-semibold text-stone-900 text-center mb-2">
            Camera Access Required
          </Text>
          <Text className="text-stone-600 text-center mb-6">
            We need camera access to scan products and identify potentially harmful ingredients.
          </Text>
          <Pressable
            className="bg-primary rounded-xl px-6 py-3 active:bg-primary-dark"
            onPress={requestPermission}
          >
            <Text className="text-white font-semibold">Grant Permission</Text>
          </Pressable>
        </View>
      </SafeAreaView>
    );
  }

  const handleCapture = async () => {
    if (!cameraRef.current || isCapturing) return;

    setIsCapturing(true);
    try {
      const photo = await cameraRef.current.takePictureAsync({
        quality: 0.8,
        base64: true,
      });

      if (photo) {
        // TODO: Process with OCR pipeline and navigate to result
        // For now, navigate to a placeholder result
        router.push('/result/demo');
      }
    } catch (error) {
      console.error('Failed to capture image:', error);
    } finally {
      setIsCapturing(false);
    }
  };

  return (
    <View className="flex-1 bg-black">
      <CameraView
        ref={cameraRef}
        style={StyleSheet.absoluteFill}
        facing="back"
      />

      {/* Overlay UI */}
      <SafeAreaView className="flex-1" edges={['top']}>
        {/* Top Bar */}
        <View className="flex-row items-center justify-between px-4 py-2">
          <Pressable
            className="w-10 h-10 bg-black/30 rounded-full items-center justify-center"
            onPress={() => router.back()}
          >
            <Ionicons name="close" size={24} color="white" />
          </Pressable>
          <View className="bg-black/30 rounded-full px-4 py-2">
            <Text className="text-white font-medium">Point at a label</Text>
          </View>
          <Pressable className="w-10 h-10 bg-black/30 rounded-full items-center justify-center">
            <Ionicons name="flash-off" size={20} color="white" />
          </Pressable>
        </View>

        {/* Scan Frame Guide */}
        <View className="flex-1 items-center justify-center">
          <View className="w-72 h-72 border-2 border-white/50 rounded-3xl">
            {/* Corner accents */}
            <View className="absolute -top-1 -left-1 w-8 h-8 border-t-4 border-l-4 border-white rounded-tl-lg" />
            <View className="absolute -top-1 -right-1 w-8 h-8 border-t-4 border-r-4 border-white rounded-tr-lg" />
            <View className="absolute -bottom-1 -left-1 w-8 h-8 border-b-4 border-l-4 border-white rounded-bl-lg" />
            <View className="absolute -bottom-1 -right-1 w-8 h-8 border-b-4 border-r-4 border-white rounded-br-lg" />
          </View>
        </View>

        {/* Bottom Controls */}
        <View className="items-center pb-8">
          {/* Capture Button */}
          <Pressable
            className={`w-20 h-20 rounded-full bg-white items-center justify-center border-4 border-primary ${
              isCapturing ? 'opacity-50' : ''
            }`}
            onPress={handleCapture}
            disabled={isCapturing}
          >
            <View className="w-16 h-16 rounded-full bg-primary" />
          </Pressable>

          <Text className="text-white/70 text-sm mt-4">
            Tap to scan ingredient label
          </Text>
        </View>
      </SafeAreaView>
    </View>
  );
}
