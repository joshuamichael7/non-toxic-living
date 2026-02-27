import { View, Text, Pressable, Linking, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import * as Clipboard from 'expo-clipboard';
import * as Haptics from 'expo-haptics';
import { useState } from 'react';
import { trackClick, type FeaturedDeal } from '@/services/api/featured';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  purple: '#8B5CF6',
  purpleBg: 'rgba(139, 92, 246, 0.1)',
  purpleBorder: 'rgba(139, 92, 246, 0.4)',
  orange: '#F97316',
  orangeBg: 'rgba(249, 115, 22, 0.1)',
  orangeBorder: 'rgba(249, 115, 22, 0.4)',
};

interface SwapDealBannerProps {
  deals: FeaturedDeal[];
}

export function SwapDealBanner({ deals }: SwapDealBannerProps) {
  const { t } = useTranslation();
  const [copiedId, setCopiedId] = useState<string | null>(null);

  if (deals.length === 0) return null;

  const handleCopyCode = async (dealId: string, code: string) => {
    await Clipboard.setStringAsync(code);
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    setCopiedId(dealId);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const handleAction = (deal: FeaturedDeal, url: string) => {
    trackClick(deal.id);
    Linking.openURL(url);
  };

  return (
    <View style={{ gap: 12 }}>
      {deals.map((deal) => {
        const isCopied = copiedId === deal.id;
        const isOnline = deal.redemption_type === 'online' || deal.redemption_type === 'both';
        const isInStore = deal.redemption_type === 'in_store' || deal.redemption_type === 'both';
        const isIbotta = deal.redemption_type === 'ibotta';

        return (
          <View
            key={deal.id}
            style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 20,
              padding: 16,
              borderWidth: 1.5,
              borderColor: colors.purpleBorder,
              borderStyle: 'dashed',
            }}
          >
            {/* Header: badge + discount */}
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 10, gap: 8 }}>
              <View style={{
                backgroundColor: colors.purpleBg,
                borderRadius: 8,
                paddingVertical: 4,
                paddingHorizontal: 8,
              }}>
                <Text style={{ fontSize: 10, fontWeight: '700', color: colors.purple, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  {deal.badge_text || t('coupon.partnerDeal')}
                </Text>
              </View>
              {deal.discount_text && (
                <View style={{
                  backgroundColor: colors.safeLight,
                  borderRadius: 8,
                  paddingVertical: 4,
                  paddingHorizontal: 8,
                  borderWidth: 1,
                  borderColor: colors.safe,
                }}>
                  <Text style={{ fontSize: 12, fontWeight: '700', color: colors.safe }}>
                    {deal.discount_text}
                  </Text>
                </View>
              )}
            </View>

            {/* Title + description */}
            <Text style={{ fontSize: 15, fontWeight: '700', color: colors.ink, marginBottom: 2 }}>
              {deal.title}
            </Text>
            {deal.description && (
              <Text style={{ fontSize: 13, color: colors.inkSecondary, lineHeight: 18, marginBottom: 8 }} numberOfLines={2}>
                {deal.description}
              </Text>
            )}
            {deal.store_name && isInStore && (
              <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 8 }}>
                <Ionicons name="storefront-outline" size={14} color={colors.inkSecondary} style={{ marginRight: 4 }} />
                <Text style={{ fontSize: 13, color: colors.inkSecondary, fontWeight: '500' }}>
                  {deal.store_name}
                </Text>
              </View>
            )}

            {/* Coupon code with copy */}
            {deal.coupon_code && (
              <Pressable
                onPress={() => handleCopyCode(deal.id, deal.coupon_code!)}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  justifyContent: 'center',
                  backgroundColor: colors.canvas,
                  borderRadius: 10,
                  paddingVertical: 10,
                  paddingHorizontal: 12,
                  borderWidth: 1,
                  borderColor: isCopied ? colors.safe : colors.glassBorder,
                  marginBottom: 10,
                }}
              >
                <Text style={{
                  fontSize: 16,
                  fontWeight: '800',
                  color: isCopied ? colors.safe : colors.ink,
                  letterSpacing: 1.5,
                  marginRight: 8,
                }}>
                  {deal.coupon_code}
                </Text>
                <Ionicons
                  name={isCopied ? 'checkmark' : 'copy-outline'}
                  size={16}
                  color={isCopied ? colors.safe : colors.inkSecondary}
                />
                {isCopied && (
                  <Text style={{ fontSize: 12, color: colors.safe, fontWeight: '600', marginLeft: 4 }}>
                    {t('deals.codeCopied')}
                  </Text>
                )}
              </Pressable>
            )}

            {/* Action buttons */}
            <View style={{ flexDirection: 'row', gap: 8 }}>
              {isOnline && deal.action_url && (
                <Pressable
                  onPress={() => handleAction(deal, deal.action_url!)}
                  style={{
                    flex: 1,
                    backgroundColor: colors.purple,
                    borderRadius: 12,
                    paddingVertical: 12,
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <Ionicons name="cart-outline" size={16} color="white" style={{ marginRight: 6 }} />
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 14 }}>
                    {t('deals.shopOnline')}
                  </Text>
                </Pressable>
              )}
              {isInStore && (
                <Pressable
                  onPress={() => {
                    // Copy code for in-store use
                    if (deal.coupon_code) {
                      handleCopyCode(deal.id, deal.coupon_code);
                    }
                  }}
                  style={{
                    flex: 1,
                    backgroundColor: colors.canvas,
                    borderRadius: 12,
                    paddingVertical: 12,
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'center',
                    borderWidth: 1,
                    borderColor: colors.purple,
                  }}
                >
                  <Ionicons name="phone-portrait-outline" size={16} color={colors.purple} style={{ marginRight: 6 }} />
                  <Text style={{ color: colors.purple, fontWeight: '700', fontSize: 14 }}>
                    {t('deals.showAtCheckout')}
                  </Text>
                </Pressable>
              )}
              {isIbotta && deal.ibotta_url && (
                <Pressable
                  onPress={() => handleAction(deal, deal.ibotta_url!)}
                  style={{
                    flex: 1,
                    backgroundColor: colors.orange,
                    borderRadius: 12,
                    paddingVertical: 12,
                    flexDirection: 'row',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <Ionicons name="cash-outline" size={16} color="white" style={{ marginRight: 6 }} />
                  <Text style={{ color: 'white', fontWeight: '700', fontSize: 14 }}>
                    {t('deals.getCashback')}
                  </Text>
                </Pressable>
              )}
            </View>

            {/* Ibotta cashback description */}
            {isIbotta && (
              <Text style={{ fontSize: 11, color: colors.inkSecondary, marginTop: 6, textAlign: 'center' }}>
                {t('deals.ibottaDesc')}
              </Text>
            )}

            {/* In-store barcode/QR display */}
            {isInStore && deal.barcode_image_url && (
              <View style={{
                marginTop: 10,
                alignItems: 'center',
                backgroundColor: 'white',
                borderRadius: 12,
                padding: 12,
              }}>
                <Image
                  source={{ uri: deal.barcode_image_url }}
                  style={{ width: 200, height: 80 }}
                  resizeMode="contain"
                />
                <Text style={{ fontSize: 11, color: colors.inkSecondary, marginTop: 4 }}>
                  {t('deals.showAtCheckout')}
                </Text>
              </View>
            )}
          </View>
        );
      })}
    </View>
  );
}
