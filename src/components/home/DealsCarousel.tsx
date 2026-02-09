import { useState, useEffect, useRef, useCallback } from 'react';
import { View, Text, ScrollView, NativeSyntheticEvent, NativeScrollEvent } from 'react-native';
import { useTranslation } from 'react-i18next';

import { getActiveCoupons, trackImpression, type CouponCard } from '@/services/api/coupons';
import { DealCard } from './DealCard';

const colors = {
  inkSecondary: '#64748B',
};

const CARD_WIDTH = 280;
const GAP = 12;
const AUTO_SCROLL_INTERVAL = 5000;

export function DealsCarousel() {
  const { t } = useTranslation();
  const [coupons, setCoupons] = useState<CouponCard[]>([]);
  const [loading, setLoading] = useState(true);

  const scrollRef = useRef<ScrollView>(null);
  const currentIndexRef = useRef(0);
  const autoScrollTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const isUserScrollingRef = useRef(false);
  const trackedImpressions = useRef<Set<string>>(new Set());

  useEffect(() => {
    getActiveCoupons(10).then((data) => {
      setCoupons(data);
      setLoading(false);
      // Track first card impression
      if (data.length > 0 && !trackedImpressions.current.has(data[0].id)) {
        trackedImpressions.current.add(data[0].id);
        trackImpression(data[0].id);
      }
    });
  }, []);

  // Auto-scroll
  const startAutoScroll = useCallback(() => {
    if (autoScrollTimerRef.current) clearInterval(autoScrollTimerRef.current);
    if (coupons.length <= 1) return;

    autoScrollTimerRef.current = setInterval(() => {
      if (isUserScrollingRef.current) return;

      const nextIndex = (currentIndexRef.current + 1) % coupons.length;
      scrollRef.current?.scrollTo({
        x: nextIndex * (CARD_WIDTH + GAP),
        animated: true,
      });
      currentIndexRef.current = nextIndex;

      // Track impression for newly visible card
      const coupon = coupons[nextIndex];
      if (coupon && !trackedImpressions.current.has(coupon.id)) {
        trackedImpressions.current.add(coupon.id);
        trackImpression(coupon.id);
      }
    }, AUTO_SCROLL_INTERVAL);
  }, [coupons]);

  useEffect(() => {
    startAutoScroll();
    return () => {
      if (autoScrollTimerRef.current) clearInterval(autoScrollTimerRef.current);
    };
  }, [startAutoScroll]);

  const handleScrollBeginDrag = () => {
    isUserScrollingRef.current = true;
    if (autoScrollTimerRef.current) clearInterval(autoScrollTimerRef.current);
  };

  const handleScrollEnd = (event: NativeSyntheticEvent<NativeScrollEvent>) => {
    isUserScrollingRef.current = false;
    const offsetX = event.nativeEvent.contentOffset.x;
    const index = Math.round(offsetX / (CARD_WIDTH + GAP));
    currentIndexRef.current = index;

    // Track impression for visible card
    const coupon = coupons[index];
    if (coupon && !trackedImpressions.current.has(coupon.id)) {
      trackedImpressions.current.add(coupon.id);
      trackImpression(coupon.id);
    }

    // Restart auto-scroll after user stops scrolling
    startAutoScroll();
  };

  // Hide entirely if no coupons
  if (!loading && coupons.length === 0) return null;
  if (loading) return null;

  return (
    <View style={{ marginBottom: 24 }}>
      <Text style={{
        fontSize: 13,
        fontWeight: '600',
        color: colors.inkSecondary,
        paddingHorizontal: 24,
        marginBottom: 14,
        letterSpacing: 0.5,
        textTransform: 'uppercase',
      }}>
        {t('deals.title')}
      </Text>
      <ScrollView
        ref={scrollRef}
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={{ paddingHorizontal: 24, gap: GAP }}
        snapToInterval={CARD_WIDTH + GAP}
        decelerationRate="fast"
        onScrollBeginDrag={handleScrollBeginDrag}
        onMomentumScrollEnd={handleScrollEnd}
        onScrollEndDrag={handleScrollEnd}
      >
        {coupons.map((coupon) => (
          <DealCard key={coupon.id} coupon={coupon} />
        ))}
      </ScrollView>
    </View>
  );
}
