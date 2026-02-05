import { View, Text } from 'react-native';

type Verdict = 'safe' | 'caution' | 'toxic';

interface ScoreBadgeProps {
  score: number;
  verdict: Verdict;
  size?: 'small' | 'medium' | 'large';
}

const sizeStyles = {
  small: { container: 'w-12 h-12', text: 'text-lg' },
  medium: { container: 'w-16 h-16', text: 'text-2xl' },
  large: { container: 'w-24 h-24', text: 'text-4xl' },
};

const verdictStyles = {
  safe: {
    bg: 'bg-safe-light',
    text: 'text-safe',
    shadow: { shadowColor: '#10B981', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
  caution: {
    bg: 'bg-caution-light',
    text: 'text-caution',
    shadow: { shadowColor: '#F59E0B', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
  toxic: {
    bg: 'bg-toxic-light',
    text: 'text-toxic',
    shadow: { shadowColor: '#F43F5E', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
};

export function ScoreBadge({ score, verdict, size = 'medium' }: ScoreBadgeProps) {
  const sizeStyle = sizeStyles[size];
  const verdictStyle = verdictStyles[verdict];

  return (
    <View
      className={`${sizeStyle.container} rounded-full items-center justify-center ${verdictStyle.bg}`}
      style={verdictStyle.shadow}
    >
      <Text className={`${sizeStyle.text} font-bold ${verdictStyle.text}`}>
        {score}
      </Text>
    </View>
  );
}
