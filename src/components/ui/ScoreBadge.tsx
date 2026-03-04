import { View, Text } from 'react-native';

type Verdict = 'safe' | 'okay' | 'caution' | 'toxic';

interface ScoreBadgeProps {
  score: number;
  verdict: Verdict;
  size?: 'small' | 'medium' | 'large';
}

const sizeStyles = {
  small: { size: 48, fontSize: 18 },
  medium: { size: 64, fontSize: 24 },
  large: { size: 96, fontSize: 36 },
};

const verdictStyles = {
  safe: {
    bg: '#D1FAE5',
    color: '#10B981',
    shadow: { shadowColor: '#10B981', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
  okay: {
    bg: 'rgba(132, 204, 22, 0.15)',
    color: '#84CC16',
    shadow: { shadowColor: '#84CC16', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
  caution: {
    bg: '#FEF3C7',
    color: '#F59E0B',
    shadow: { shadowColor: '#F59E0B', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
  toxic: {
    bg: '#FFE4E6',
    color: '#F43F5E',
    shadow: { shadowColor: '#F43F5E', shadowOpacity: 0.25, shadowRadius: 14, shadowOffset: { width: 0, height: 4 } },
  },
};

export function ScoreBadge({ score, verdict, size = 'medium' }: ScoreBadgeProps) {
  const s = sizeStyles[size];
  const v = verdictStyles[verdict];

  return (
    <View
      style={[
        {
          width: s.size,
          height: s.size,
          borderRadius: s.size / 2,
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: v.bg,
        },
        v.shadow,
      ]}
    >
      <Text style={{ fontSize: s.fontSize, fontWeight: '700', color: v.color }}>
        {score}
      </Text>
    </View>
  );
}
