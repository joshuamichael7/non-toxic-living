import { useState, useEffect, useRef, useCallback } from 'react';
import { View, Text, ScrollView, NativeSyntheticEvent, NativeScrollEvent } from 'react-native';
import { useTranslation } from 'react-i18next';

import { getActiveFeaturedItems, trackImpression, type FeaturedItem } from '@/services/api/featured';
import { FeaturedCard } from './FeaturedCard';

const colors = {
  inkSecondary: '#64748B',
};

const CARD_WIDTH = 280;
const GAP = 12;
const AUTO_SCROLL_INTERVAL = 5000;

export function FeaturedCarousel() {
  const { t } = useTranslation();
  const [items, setItems] = useState<FeaturedItem[]>([]);
  const [loading, setLoading] = useState(true);

  const scrollRef = useRef<ScrollView>(null);
  const currentIndexRef = useRef(0);
  const autoScrollTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const isUserScrollingRef = useRef(false);
  const trackedImpressions = useRef<Set<string>>(new Set());

  useEffect(() => {
    getActiveFeaturedItems(10).then((data) => {
      setItems(data);
      setLoading(false);
      if (data.length > 0 && !trackedImpressions.current.has(data[0].id)) {
        trackedImpressions.current.add(data[0].id);
        trackImpression(data[0].id);
      }
    });
  }, []);

  const startAutoScroll = useCallback(() => {
    if (autoScrollTimerRef.current) clearInterval(autoScrollTimerRef.current);
    if (items.length <= 1) return;

    autoScrollTimerRef.current = setInterval(() => {
      if (isUserScrollingRef.current) return;

      const nextIndex = (currentIndexRef.current + 1) % items.length;
      scrollRef.current?.scrollTo({
        x: nextIndex * (CARD_WIDTH + GAP),
        animated: true,
      });
      currentIndexRef.current = nextIndex;

      const item = items[nextIndex];
      if (item && !trackedImpressions.current.has(item.id)) {
        trackedImpressions.current.add(item.id);
        trackImpression(item.id);
      }
    }, AUTO_SCROLL_INTERVAL);
  }, [items]);

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

    const item = items[index];
    if (item && !trackedImpressions.current.has(item.id)) {
      trackedImpressions.current.add(item.id);
      trackImpression(item.id);
    }

    startAutoScroll();
  };

  if (!loading && items.length === 0) return null;
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
        {t('featured.title')}
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
        {items.map((item) => (
          <FeaturedCard key={item.id} item={item} />
        ))}
      </ScrollView>
    </View>
  );
}
