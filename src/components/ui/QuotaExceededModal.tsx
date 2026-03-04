import { View, Text, Pressable, Modal } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import { useRouter } from 'expo-router';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  caution: '#F59E0B',
  cautionGlow: 'rgba(245, 158, 11, 0.12)',
};

interface QuotaExceededModalProps {
  visible: boolean;
  onClose: () => void;
}

export function QuotaExceededModal({ visible, onClose }: QuotaExceededModalProps) {
  const { t } = useTranslation();
  const router = useRouter();

  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onClose}
    >
      <View style={{
        flex: 1,
        backgroundColor: 'rgba(0, 0, 0, 0.5)',
        justifyContent: 'center',
        alignItems: 'center',
        padding: 24,
      }}>
        <View style={{
          backgroundColor: colors.glassSolid,
          borderRadius: 24,
          padding: 28,
          width: '100%',
          maxWidth: 360,
          alignItems: 'center',
        }}>
          {/* Icon */}
          <View style={{
            width: 64,
            height: 64,
            borderRadius: 32,
            backgroundColor: colors.cautionGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 20,
          }}>
            <Ionicons name="scan-outline" size={32} color={colors.caution} />
          </View>

          {/* Title */}
          <Text style={{
            fontSize: 22,
            fontWeight: '800',
            color: colors.ink,
            textAlign: 'center',
            marginBottom: 8,
          }}>
            {t('credits.outTitle')}
          </Text>

          {/* Description */}
          <Text style={{
            fontSize: 15,
            color: colors.inkSecondary,
            textAlign: 'center',
            lineHeight: 22,
            marginBottom: 28,
          }}>
            {t('credits.outDesc')}
          </Text>

          {/* Buy credits button */}
          <Pressable
            onPress={() => {
              onClose();
              router.push('/subscription' as any);
            }}
            style={{
              backgroundColor: colors.oxygen,
              borderRadius: 16,
              paddingVertical: 16,
              width: '100%',
              alignItems: 'center',
              marginBottom: 12,
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 6 },
              shadowOpacity: 0.3,
              shadowRadius: 12,
            }}
          >
            <Text style={{ color: 'white', fontWeight: '700', fontSize: 17 }}>
              {t('credits.buyMore')}
            </Text>
          </Pressable>

          {/* Dismiss */}
          <Pressable onPress={onClose} style={{ paddingVertical: 8 }}>
            <Text style={{ color: colors.inkSecondary, fontWeight: '600', fontSize: 15 }}>
              {t('quota.dismiss')}
            </Text>
          </Pressable>
        </View>
      </View>
    </Modal>
  );
}
