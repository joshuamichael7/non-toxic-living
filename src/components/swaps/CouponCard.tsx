import { View, Text, Pressable, Linking } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Clipboard from 'expo-clipboard';
import * as Haptics from 'expo-haptics';
import { useState } from 'react';
import type { Coupon } from '@/services/api/analyze';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  couponBg: 'rgba(139, 92, 246, 0.1)',
  couponColor: '#8B5CF6',
  couponBorder: '#8B5CF6',
};

interface CouponCardProps {
  coupon: Coupon;
}

export function CouponCard({ coupon }: CouponCardProps) {
  const { t } = useTranslation();
  const [copied, setCopied] = useState(false);

  const handleCopyCode = async () => {
    await Clipboard.setStringAsync(coupon.coupon_code);
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const handleRedeem = () => {
    if (coupon.redemption_url) {
      Linking.openURL(coupon.redemption_url);
    }
  };

  const discountLabel = coupon.discount_type === 'percent' && coupon.discount_value
    ? `${coupon.discount_value}% off`
    : coupon.discount_type === 'fixed' && coupon.discount_value
    ? `$${coupon.discount_value} off`
    : coupon.discount_type === 'free_shipping'
    ? t('coupon.freeShipping')
    : coupon.discount_type === 'bogo'
    ? t('coupon.bogo')
    : '';

  const expiresAt = coupon.expires_at ? new Date(coupon.expires_at) : null;
  const daysLeft = expiresAt
    ? Math.max(0, Math.ceil((expiresAt.getTime() - Date.now()) / (1000 * 60 * 60 * 24)))
    : null;

  return (
    <View style={{
      backgroundColor: colors.glassSolid,
      borderRadius: 20,
      padding: 16,
      borderWidth: 1.5,
      borderColor: colors.couponBorder,
      borderStyle: 'dashed',
    }}>
      {/* Badge + Brand */}
      <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 10 }}>
        <View style={{
          backgroundColor: colors.couponBg,
          borderRadius: 8,
          paddingVertical: 4,
          paddingHorizontal: 8,
          marginRight: 8,
        }}>
          <Text style={{ fontSize: 10, fontWeight: '700', color: colors.couponColor, textTransform: 'uppercase', letterSpacing: 0.5 }}>
            {coupon.badge_text || t('coupon.partnerDeal')}
          </Text>
        </View>
        <Text style={{ fontSize: 13, color: colors.inkSecondary, fontWeight: '500', flex: 1 }}>
          {coupon.brand_name}
        </Text>
        {daysLeft !== null && daysLeft <= 14 && (
          <Text style={{ fontSize: 11, color: colors.couponColor, fontWeight: '600' }}>
            {t('coupon.expiresIn', { days: daysLeft })}
          </Text>
        )}
      </View>

      {/* Title + Description */}
      <Text style={{ fontSize: 16, fontWeight: '700', color: colors.ink, marginBottom: 4 }}>
        {coupon.title}
      </Text>
      {coupon.description && (
        <Text style={{ fontSize: 13, color: colors.inkSecondary, lineHeight: 18, marginBottom: 10 }}>
          {coupon.description}
        </Text>
      )}

      {/* Discount + Code */}
      <View style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
        {discountLabel ? (
          <View style={{
            backgroundColor: colors.safeLight,
            borderRadius: 8,
            paddingVertical: 6,
            paddingHorizontal: 10,
            borderWidth: 1,
            borderColor: colors.safe,
          }}>
            <Text style={{ fontSize: 13, fontWeight: '700', color: colors.safe }}>{discountLabel}</Text>
          </View>
        ) : null}

        <Pressable
          onPress={handleCopyCode}
          style={{
            flex: 1,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            backgroundColor: colors.canvas,
            borderRadius: 10,
            paddingVertical: 10,
            paddingHorizontal: 12,
            borderWidth: 1,
            borderColor: copied ? colors.safe : colors.glassBorder,
          }}
        >
          <Text style={{
            fontSize: 15,
            fontWeight: '800',
            color: copied ? colors.safe : colors.ink,
            letterSpacing: 1,
            marginRight: 6,
          }}>
            {coupon.coupon_code}
          </Text>
          <Ionicons
            name={copied ? 'checkmark' : 'copy-outline'}
            size={16}
            color={copied ? colors.safe : colors.inkSecondary}
          />
        </Pressable>
      </View>

      {/* Redeem button */}
      {coupon.redemption_url && (
        <Pressable
          onPress={handleRedeem}
          style={{
            marginTop: 12,
            backgroundColor: colors.couponColor,
            borderRadius: 12,
            paddingVertical: 12,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <Ionicons name="gift-outline" size={18} color="white" style={{ marginRight: 8 }} />
          <Text style={{ color: 'white', fontWeight: '700', fontSize: 15 }}>
            {t('coupon.redeem')}
          </Text>
        </Pressable>
      )}
    </View>
  );
}
