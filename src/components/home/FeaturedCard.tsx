import { useState } from 'react';
import { View, Text, Pressable, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Clipboard from 'expo-clipboard';
import * as Haptics from 'expo-haptics';
import * as Linking from 'expo-linking';

import type { FeaturedItem } from '@/services/api/featured';
import { trackClick } from '@/services/api/featured';

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
  purple: '#8B5CF6',
  purpleGlow: 'rgba(139, 92, 246, 0.15)',
};

interface FeaturedCardProps {
  item: FeaturedItem;
}

function getDaysLeft(expiresAt: string | null): number | null {
  if (!expiresAt) return null;
  const diff = new Date(expiresAt).getTime() - Date.now();
  return Math.max(0, Math.ceil(diff / (1000 * 60 * 60 * 24)));
}

function getBadgeColor(type: FeaturedItem['type']) {
  switch (type) {
    case 'coupon': return { bg: colors.oxygenGlow, text: colors.oxygen };
    case 'product': return { bg: 'rgba(16, 185, 129, 0.15)', text: colors.safe };
    case 'sponsored': return { bg: colors.purpleGlow, text: colors.purple };
  }
}

export function FeaturedCard({ item }: FeaturedCardProps) {
  const { t } = useTranslation();
  const [copied, setCopied] = useState(false);
  const [showBarcode, setShowBarcode] = useState(false);

  const daysLeft = getDaysLeft(item.expires_at);
  const badgeColor = getBadgeColor(item.type);
  const displayName = item.store_name || item.brand_name;

  const handleAction = async () => {
    trackClick(item.id);

    if (item.type === 'coupon' && item.coupon_code) {
      await Clipboard.setStringAsync(item.coupon_code);
      await Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
      if (item.action_url) {
        setTimeout(() => Linking.openURL(item.action_url!), 500);
      }
    } else if (item.action_url) {
      Linking.openURL(item.action_url);
    }
  };

  const handleInStoreRedeem = () => {
    trackClick(item.id);
    setShowBarcode(!showBarcode);
  };

  const isOnline = item.redemption_type === 'online';
  const isInStore = item.redemption_type === 'in_store';
  const isBoth = item.redemption_type === 'both';
  const isCoupon = item.type === 'coupon';

  // Determine button label
  const getButtonLabel = () => {
    if (isCoupon && copied) return t('coupon.copied');
    if (item.action_label) return item.action_label;
    if (item.type === 'product') return t('featured.shopNow');
    if (item.type === 'sponsored') return t('featured.learnMore');
    return t('deals.shopNow');
  };

  // Determine button icon
  const getButtonIcon = (): keyof typeof Ionicons.glyphMap => {
    if (isCoupon && copied) return 'checkmark-circle';
    if (item.type === 'product') return 'cart-outline';
    if (item.type === 'sponsored') return 'open-outline';
    return 'cart-outline';
  };

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
          backgroundColor: badgeColor.bg,
          borderRadius: 8,
          paddingHorizontal: 8,
          paddingVertical: 4,
        }}>
          <Text style={{ color: badgeColor.text, fontSize: 10, fontWeight: '700', letterSpacing: 0.5, textTransform: 'uppercase' }}>
            {item.badge_text || 'FEATURED'}
          </Text>
        </View>
        {daysLeft !== null && (
          <Text style={{ color: daysLeft <= 3 ? colors.caution : colors.inkMuted, fontSize: 11, fontWeight: '600' }}>
            {t('coupon.expiresIn', { days: daysLeft })}
          </Text>
        )}
      </View>

      {/* Product image (for product/sponsored types) */}
      {item.image_url && (item.type === 'product' || item.type === 'sponsored') && (
        <Image
          source={{ uri: item.image_url }}
          style={{
            width: '100%',
            height: 120,
            borderRadius: 12,
            marginBottom: 12,
          }}
          resizeMode="cover"
        />
      )}

      {/* Brand/Store name */}
      {displayName && (
        <Text style={{ fontSize: 11, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase', marginBottom: 4 }}>
          {displayName}
        </Text>
      )}

      {/* Title */}
      <Text style={{ fontSize: 15, fontWeight: '700', color: colors.ink, marginBottom: 4, lineHeight: 20 }} numberOfLines={2}>
        {item.title}
      </Text>

      {/* Subtitle */}
      {item.subtitle && (
        <Text style={{ fontSize: 13, color: colors.inkSecondary, marginBottom: 8, lineHeight: 18 }} numberOfLines={2}>
          {item.subtitle}
        </Text>
      )}

      {/* Discount text (for coupons) */}
      {item.discount_text && (
        <Text style={{ fontSize: 18, fontWeight: '800', color: colors.oxygen, marginBottom: 14 }}>
          {item.discount_text}
        </Text>
      )}

      {/* Spacer if no discount text */}
      {!item.discount_text && <View style={{ height: 6 }} />}

      {/* Primary action button */}
      {(!isCoupon || isOnline || isBoth) && (
        <Pressable
          onPress={handleAction}
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
            marginBottom: isCoupon && isBoth ? 8 : 0,
          }}
        >
          <Ionicons name={getButtonIcon()} size={16} color="white" style={{ marginRight: 6 }} />
          <Text style={{ color: 'white', fontWeight: '700', fontSize: 14 }}>
            {getButtonLabel()}
          </Text>
        </Pressable>
      )}

      {/* In-store only button (for coupons) */}
      {isCoupon && isInStore && (
        <Pressable
          onPress={handleInStoreRedeem}
          style={{
            backgroundColor: colors.oxygen,
            borderRadius: 14,
            paddingVertical: 12,
            alignItems: 'center',
            flexDirection: 'row',
            justifyContent: 'center',
          }}
        >
          <Ionicons name="storefront-outline" size={16} color="white" style={{ marginRight: 6 }} />
          <Text style={{ color: 'white', fontWeight: '700', fontSize: 14 }}>
            {t('deals.showAtCheckout')}
          </Text>
        </Pressable>
      )}

      {/* Secondary in-store button (for coupon type=both) */}
      {isCoupon && isBoth && (
        <Pressable
          onPress={handleInStoreRedeem}
          style={{
            backgroundColor: 'transparent',
            borderRadius: 14,
            paddingVertical: 12,
            alignItems: 'center',
            flexDirection: 'row',
            justifyContent: 'center',
            borderWidth: 1.5,
            borderColor: colors.oxygen,
          }}
        >
          <Ionicons name="storefront-outline" size={16} color={colors.oxygen} style={{ marginRight: 6 }} />
          <Text style={{ color: colors.oxygen, fontWeight: '700', fontSize: 14 }}>
            {t('deals.showAtCheckout')}
          </Text>
        </Pressable>
      )}

      {/* Expanded barcode/code display for in-store */}
      {showBarcode && isCoupon && (isInStore || isBoth) && (
        <View style={{
          marginTop: 12,
          backgroundColor: 'white',
          borderRadius: 12,
          padding: 16,
          alignItems: 'center',
        }}>
          {item.barcode_image_url ? (
            <Image
              source={{ uri: item.barcode_image_url }}
              style={{ width: 220, height: 80, resizeMode: 'contain', marginBottom: 8 }}
            />
          ) : null}
          {item.coupon_code && (
            <Text style={{ fontSize: 20, fontWeight: '800', color: colors.ink, letterSpacing: 2 }}>
              {item.coupon_code}
            </Text>
          )}
          <Text style={{ fontSize: 11, color: colors.inkMuted, marginTop: 4 }}>
            {item.store_name ? `Show at ${item.store_name}` : t('deals.showAtCheckout')}
          </Text>
        </View>
      )}
    </View>
  );
}
