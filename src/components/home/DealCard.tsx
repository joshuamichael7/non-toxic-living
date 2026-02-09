import { useState } from 'react';
import { View, Text, Pressable, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Clipboard from 'expo-clipboard';
import * as Haptics from 'expo-haptics';
import * as Linking from 'expo-linking';

import type { CouponCard } from '@/services/api/coupons';
import { trackClick } from '@/services/api/coupons';

const colors = {
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  caution: '#F59E0B',
  safe: '#10B981',
};

interface DealCardProps {
  coupon: CouponCard;
}

function getDiscountLabel(coupon: CouponCard): string {
  switch (coupon.discount_type) {
    case 'percent':
      return `${coupon.discount_value}% OFF`;
    case 'fixed':
      return `$${coupon.discount_value} OFF`;
    case 'free_shipping':
      return 'FREE SHIPPING';
    case 'bogo':
      return 'BUY 1 GET 1';
    default:
      return coupon.badge_text || 'DEAL';
  }
}

function getDaysLeft(expiresAt: string | null): number | null {
  if (!expiresAt) return null;
  const diff = new Date(expiresAt).getTime() - Date.now();
  return Math.max(0, Math.ceil(diff / (1000 * 60 * 60 * 24)));
}

export function DealCard({ coupon }: DealCardProps) {
  const { t } = useTranslation();
  const [copied, setCopied] = useState(false);
  const [showBarcode, setShowBarcode] = useState(false);

  const daysLeft = getDaysLeft(coupon.expires_at);
  const discountLabel = getDiscountLabel(coupon);
  const displayName = coupon.store_name || coupon.brand_name;

  const handleOnlineRedeem = async () => {
    await Clipboard.setStringAsync(coupon.coupon_code);
    await Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    setCopied(true);
    trackClick(coupon.id);
    setTimeout(() => setCopied(false), 2000);

    if (coupon.redemption_url) {
      setTimeout(() => Linking.openURL(coupon.redemption_url!), 500);
    }
  };

  const handleInStoreRedeem = () => {
    trackClick(coupon.id);
    setShowBarcode(!showBarcode);
  };

  const isOnline = coupon.redemption_type === 'online';
  const isInStore = coupon.redemption_type === 'in_store';
  const isBoth = coupon.redemption_type === 'both';

  return (
    <View style={{
      backgroundColor: colors.glassSolid,
      borderRadius: 24,
      padding: 20,
      width: 280,
      borderWidth: 1,
      borderColor: colors.glassBorder,
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.04,
      shadowRadius: 12,
    }}>
      {/* Badge row */}
      <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
        <View style={{
          backgroundColor: colors.oxygenGlow,
          borderRadius: 8,
          paddingHorizontal: 8,
          paddingVertical: 4,
        }}>
          <Text style={{ color: colors.oxygen, fontSize: 10, fontWeight: '700', letterSpacing: 0.5, textTransform: 'uppercase' }}>
            {coupon.badge_text || t('coupon.partnerDeal')}
          </Text>
        </View>
        {daysLeft !== null && (
          <Text style={{ color: daysLeft <= 3 ? colors.caution : colors.inkMuted, fontSize: 11, fontWeight: '600' }}>
            {t('coupon.expiresIn', { days: daysLeft })}
          </Text>
        )}
      </View>

      {/* Brand/Store name */}
      <Text style={{ fontSize: 11, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase', marginBottom: 4 }}>
        {displayName}
      </Text>

      {/* Title */}
      <Text style={{ fontSize: 15, fontWeight: '700', color: colors.ink, marginBottom: 8, lineHeight: 20 }} numberOfLines={2}>
        {coupon.title}
      </Text>

      {/* Discount */}
      <Text style={{ fontSize: 18, fontWeight: '800', color: colors.oxygen, marginBottom: 14 }}>
        {discountLabel}
      </Text>

      {/* Action buttons */}
      {(isOnline || isBoth) && (
        <Pressable
          onPress={handleOnlineRedeem}
          style={{
            backgroundColor: colors.oxygen,
            borderRadius: 14,
            paddingVertical: 12,
            alignItems: 'center',
            flexDirection: 'row',
            justifyContent: 'center',
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.25,
            shadowRadius: 8,
            marginBottom: isBoth ? 8 : 0,
          }}
        >
          <Ionicons name={copied ? 'checkmark-circle' : 'cart-outline'} size={16} color="white" style={{ marginRight: 6 }} />
          <Text style={{ color: 'white', fontWeight: '700', fontSize: 14 }}>
            {copied ? t('coupon.copied') : t('deals.shopNow')}
          </Text>
        </Pressable>
      )}

      {(isInStore || isBoth) && (
        <Pressable
          onPress={handleInStoreRedeem}
          style={{
            backgroundColor: isBoth ? 'transparent' : colors.oxygen,
            borderRadius: 14,
            paddingVertical: 12,
            alignItems: 'center',
            flexDirection: 'row',
            justifyContent: 'center',
            borderWidth: isBoth ? 1.5 : 0,
            borderColor: colors.oxygen,
          }}
        >
          <Ionicons name="storefront-outline" size={16} color={isBoth ? colors.oxygen : 'white'} style={{ marginRight: 6 }} />
          <Text style={{ color: isBoth ? colors.oxygen : 'white', fontWeight: '700', fontSize: 14 }}>
            {t('deals.showAtCheckout')}
          </Text>
        </Pressable>
      )}

      {/* Expanded barcode/code display for in-store */}
      {showBarcode && (isInStore || isBoth) && (
        <View style={{
          marginTop: 12,
          backgroundColor: 'white',
          borderRadius: 12,
          padding: 16,
          alignItems: 'center',
        }}>
          {coupon.barcode_image_url ? (
            <Image
              source={{ uri: coupon.barcode_image_url }}
              style={{ width: 220, height: 80, resizeMode: 'contain', marginBottom: 8 }}
            />
          ) : null}
          <Text style={{ fontSize: 20, fontWeight: '800', color: colors.ink, letterSpacing: 2 }}>
            {coupon.coupon_code}
          </Text>
          <Text style={{ fontSize: 11, color: colors.inkMuted, marginTop: 4 }}>
            {coupon.store_name ? `Show at ${coupon.store_name}` : t('deals.showAtCheckout')}
          </Text>
        </View>
      )}
    </View>
  );
}
