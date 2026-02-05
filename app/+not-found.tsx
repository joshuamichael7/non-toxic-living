import { View, Text, Pressable } from 'react-native';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

export default function NotFoundScreen() {
  const router = useRouter();

  return (
    <View className="flex-1 bg-stone-50 items-center justify-center px-6">
      <View className="w-20 h-20 bg-stone-200 rounded-full items-center justify-center mb-6">
        <Ionicons name="help-outline" size={40} color="#57534E" />
      </View>
      <Text className="text-2xl font-bold text-stone-900 mb-2">Page Not Found</Text>
      <Text className="text-stone-600 text-center mb-6">
        The page you're looking for doesn't exist.
      </Text>
      <Pressable
        className="bg-primary rounded-xl px-6 py-3"
        onPress={() => router.replace('/')}
      >
        <Text className="text-white font-semibold">Go Home</Text>
      </Pressable>
    </View>
  );
}
