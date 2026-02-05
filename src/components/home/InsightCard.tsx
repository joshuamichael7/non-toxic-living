import { View, Text, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

type InsightColor = 'safe' | 'caution' | 'toxic';

interface InsightCardProps {
  title: string;
  description: string;
  icon: keyof typeof Ionicons.glyphMap;
  color: InsightColor;
  onPress?: () => void;
}

const colorStyles = {
  safe: {
    bg: 'bg-safe-light',
    iconBg: 'bg-safe/20',
    iconColor: '#10B981',
  },
  caution: {
    bg: 'bg-caution-light',
    iconBg: 'bg-caution/20',
    iconColor: '#F59E0B',
  },
  toxic: {
    bg: 'bg-toxic-light',
    iconBg: 'bg-toxic/20',
    iconColor: '#F43F5E',
  },
};

export function InsightCard({ title, description, icon, color, onPress }: InsightCardProps) {
  const styles = colorStyles[color];

  return (
    <Pressable
      className={`${styles.bg} rounded-2xl p-4 w-72`}
      onPress={onPress}
    >
      <View className={`w-10 h-10 ${styles.iconBg} rounded-xl items-center justify-center mb-3`}>
        <Ionicons name={icon} size={20} color={styles.iconColor} />
      </View>
      <Text className="text-stone-900 font-semibold text-base mb-1">{title}</Text>
      <Text className="text-stone-600 text-sm leading-relaxed">{description}</Text>
    </Pressable>
  );
}
