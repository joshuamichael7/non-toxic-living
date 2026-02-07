import { View, Text, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

type InsightColor = 'primary' | 'safe' | 'caution' | 'toxic';

interface InsightCardProps {
  title: string;
  description: string;
  icon: keyof typeof Ionicons.glyphMap;
  color: InsightColor;
  onPress?: () => void;
}

// Aerogel Design System Colors
const colorStyles: Record<InsightColor, { bg: string; iconBg: string; iconColor: string; glow: string }> = {
  primary: {
    bg: '#F0F0F0',
    iconBg: 'rgba(14, 165, 233, 0.15)',
    iconColor: '#0EA5E9',
    glow: 'rgba(14, 165, 233, 0.2)',
  },
  safe: {
    bg: '#F0F0F0',
    iconBg: 'rgba(16, 185, 129, 0.15)',
    iconColor: '#10B981',
    glow: 'rgba(16, 185, 129, 0.2)',
  },
  caution: {
    bg: '#F0F0F0',
    iconBg: 'rgba(245, 158, 11, 0.15)',
    iconColor: '#F59E0B',
    glow: 'rgba(245, 158, 11, 0.2)',
  },
  toxic: {
    bg: '#F0F0F0',
    iconBg: 'rgba(239, 68, 68, 0.15)',
    iconColor: '#EF4444',
    glow: 'rgba(239, 68, 68, 0.2)',
  },
};

export function InsightCard({ title, description, icon, color, onPress }: InsightCardProps) {
  const styles = colorStyles[color];

  return (
    <Pressable
      style={{
        backgroundColor: styles.bg,
        borderRadius: 24,
        padding: 20,
        width: 280,
        borderWidth: 1,
        borderColor: 'rgba(255, 255, 255, 0.6)',
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.04,
        shadowRadius: 12,
      }}
      onPress={onPress}
    >
      <View style={{
        width: 44,
        height: 44,
        backgroundColor: styles.iconBg,
        borderRadius: 14,
        alignItems: 'center',
        justifyContent: 'center',
        marginBottom: 16,
        shadowColor: styles.iconColor,
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.2,
        shadowRadius: 8,
      }}>
        <Ionicons name={icon} size={22} color={styles.iconColor} />
      </View>
      <Text style={{ fontSize: 13, fontWeight: '600', color: '#64748B', marginBottom: 6, letterSpacing: 0.3, textTransform: 'uppercase' }}>
        {title}
      </Text>
      <Text style={{ fontSize: 15, color: '#1A1A1A', lineHeight: 22, fontWeight: '500' }}>
        {description}
      </Text>
    </Pressable>
  );
}
