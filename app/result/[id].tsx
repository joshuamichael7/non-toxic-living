import { useState } from 'react';
import { View, Text, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useLocalSearchParams, useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';

import { useScanStore } from '@/stores/useScanStore';
import { usePreferencesStore } from '@/stores/usePreferencesStore';
import { StorePrompt } from '@/components/swaps/StorePrompt';

// Aerogel Design System Colors
const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenDeep: '#0284C7',
  oxygenLight: '#38BDF8',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  safe: '#10B981',
  safeLight: 'rgba(16, 185, 129, 0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245, 158, 11, 0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239, 68, 68, 0.15)',
};

// Demo data for when accessed directly (e.g., /result/demo)
const DEMO_RESULT = {
  productName: 'Cheetos Crunchy',
  brand: 'Frito-Lay',
  category: 'food',
  score: 34,
  verdict: 'caution' as const,
  summary: 'Contains several artificial additives and highly processed ingredients that may have negative health effects.',
  dadsTake: "I keep these out of my house. The artificial colors and MSG derivatives aren't worth it when there are better options that taste just as good.",
  concerns: [
    { ingredient: 'Yellow 6', severity: 'medium' as const, description: 'Artificial color linked to hyperactivity in children', category: 'color' },
    { ingredient: 'Red 40', severity: 'medium' as const, description: 'Synthetic dye with potential carcinogenic properties', category: 'color' },
    { ingredient: 'MSG', severity: 'low' as const, description: 'Flavor enhancer that may cause sensitivity reactions', category: 'additive' },
  ],
  positives: ['No trans fats', 'Gluten-free'],
  swaps: [
    { id: '1', name: 'Lesser Evil Paleo Puffs', brand: 'Lesser Evil', score: 82 },
    { id: '2', name: 'Hippeas Organic Chickpea Puffs', brand: 'Hippeas', score: 78 },
  ],
  ocrSource: 'device' as const,
  model: 'gpt-4o-mini',
  cached: false,
  cachedAt: undefined,
};

const severityConfig = {
  low: { bg: colors.glassSolid, color: colors.inkSecondary, borderColor: colors.glassBorder },
  medium: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution },
  high: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic },
};

export default function ResultScreen() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const { currentResult, clearScan } = useScanStore();
  const { t } = useTranslation();

  const verdictConfig = {
    safe: { bg: colors.safeLight, color: colors.safe, borderColor: colors.safe, label: t('verdict.safe'), icon: 'checkmark-circle' as const },
    caution: { bg: colors.cautionLight, color: colors.caution, borderColor: colors.caution, label: t('verdict.caution'), icon: 'alert-circle' as const },
    toxic: { bg: colors.toxicLight, color: colors.toxic, borderColor: colors.toxic, label: t('verdict.toxic'), icon: 'close-circle' as const },
  };

  // Use store result if available, otherwise fall back to demo
  const result = id === 'scan' && currentResult ? currentResult : DEMO_RESULT;
  const config = verdictConfig[result.verdict];

  const handleClose = () => {
    clearScan();
    router.back();
  };

  const handleScanAgain = () => {
    clearScan();
    router.replace('/(tabs)/scan');
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.canvas }} edges={['top']}>
      {/* Header */}
      <View style={{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 20,
        paddingVertical: 12,
      }}>
        <Pressable
          style={{
            width: 44,
            height: 44,
            borderRadius: 14,
            backgroundColor: colors.glassSolid,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            alignItems: 'center',
            justifyContent: 'center'
          }}
          onPress={handleClose}
        >
          <Ionicons name="close" size={24} color={colors.ink} />
        </Pressable>
        <Text style={{ fontSize: 14, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.5, textTransform: 'uppercase' }}>{t('result.title')}</Text>
        <Pressable style={{
          width: 44,
          height: 44,
          borderRadius: 14,
          backgroundColor: colors.glassSolid,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          alignItems: 'center',
          justifyContent: 'center'
        }}>
          <Ionicons name="share-outline" size={22} color={colors.ink} />
        </Pressable>
      </View>

      <ScrollView
        style={{ flex: 1 }}
        contentContainerStyle={{ paddingBottom: 120 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Cached Result Badge */}
        {result.cached && (
          <View style={{
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            marginHorizontal: 20,
            marginBottom: 12,
          }}>
            <View style={{
              flexDirection: 'row',
              alignItems: 'center',
              backgroundColor: colors.oxygenGlow,
              borderRadius: 12,
              paddingVertical: 8,
              paddingHorizontal: 14,
              borderWidth: 1,
              borderColor: colors.oxygen,
            }}>
              <Ionicons name="flash" size={16} color={colors.oxygen} style={{ marginRight: 6 }} />
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.oxygen }}>
                {t('result.cached')}
              </Text>
            </View>
          </View>
        )}

        {/* Score Hero - Glass with colored accent */}
        <View style={{
          backgroundColor: colors.glassSolid,
          marginHorizontal: 20,
          borderRadius: 32,
          padding: 28,
          alignItems: 'center',
          marginBottom: 20,
          borderWidth: 1,
          borderColor: colors.glassBorder,
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 8 },
          shadowOpacity: 0.06,
          shadowRadius: 24,
        }}>
          {/* Score Ring */}
          <View style={{
            width: 120,
            height: 120,
            borderRadius: 40,
            backgroundColor: config.bg,
            alignItems: 'center',
            justifyContent: 'center',
            marginBottom: 20,
            borderWidth: 4,
            borderColor: config.borderColor,
            shadowColor: config.color,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}>
            <Text style={{ fontSize: 48, fontWeight: '800', color: config.color }}>{result.score}</Text>
          </View>
          <Text style={{ fontSize: 24, fontWeight: '800', color: colors.ink, textAlign: 'center', marginBottom: 4 }}>
            {result.productName}
          </Text>
          <Text style={{ fontSize: 14, color: colors.inkSecondary, marginBottom: 16, fontWeight: '500' }}>{result.brand}</Text>
          <View style={{
            flexDirection: 'row',
            alignItems: 'center',
            backgroundColor: config.bg,
            borderRadius: 12,
            paddingVertical: 8,
            paddingHorizontal: 16,
            borderWidth: 1,
            borderColor: config.borderColor,
          }}>
            <Ionicons name={config.icon} size={18} color={config.color} style={{ marginRight: 6 }} />
            <Text style={{ fontSize: 14, fontWeight: '700', color: config.color }}>
              {config.label}
            </Text>
          </View>
        </View>

        {/* Summary - Glass card */}
        <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
          <View style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 24,
            padding: 20,
            borderWidth: 1,
            borderColor: colors.glassBorder,
            shadowColor: '#000',
            shadowOffset: { width: 0, height: 4 },
            shadowOpacity: 0.04,
            shadowRadius: 12,
          }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
              <View style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                backgroundColor: colors.oxygenGlow,
                alignItems: 'center',
                justifyContent: 'center',
                marginRight: 10,
              }}>
                <Ionicons name="document-text" size={16} color={colors.oxygen} />
              </View>
              <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, letterSpacing: 0.3, textTransform: 'uppercase' }}>{t('result.summary')}</Text>
            </View>
            <Text style={{ fontSize: 15, color: colors.ink, lineHeight: 24, fontWeight: '500' }}>{result.summary}</Text>
          </View>
        </View>

        {/* Dad's Take - Accent card with oxygen glow */}
        <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
          <View style={{
            backgroundColor: colors.oxygen,
            borderRadius: 24,
            padding: 20,
            shadowColor: colors.oxygen,
            shadowOffset: { width: 0, height: 8 },
            shadowOpacity: 0.3,
            shadowRadius: 16,
          }}>
            <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12 }}>
              <View style={{
                width: 32,
                height: 32,
                borderRadius: 10,
                backgroundColor: 'rgba(255, 255, 255, 0.2)',
                alignItems: 'center',
                justifyContent: 'center',
                marginRight: 10,
              }}>
                <Ionicons name="chatbubble" size={16} color="white" />
              </View>
              <Text style={{ fontSize: 13, fontWeight: '700', color: 'white', letterSpacing: 0.3, textTransform: 'uppercase' }}>{t('result.expertTake')}</Text>
            </View>
            <Text style={{ fontSize: 15, color: 'white', lineHeight: 24, fontWeight: '500' }}>
              "{result.dadsTake}"
            </Text>
          </View>
        </View>

        {/* Concerns */}
        {result.concerns && result.concerns.length > 0 && (
          <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('result.concerns', { count: result.concerns.length })}
            </Text>
            <View style={{ gap: 10 }}>
              {result.concerns.map((concern, index) => {
                const sConfig = severityConfig[concern.severity];
                return (
                  <View
                    key={`${concern.ingredient}-${index}`}
                    style={{
                      backgroundColor: colors.glassSolid,
                      borderRadius: 20,
                      padding: 16,
                      borderWidth: 1,
                      borderColor: colors.glassBorder,
                      shadowColor: '#000',
                      shadowOffset: { width: 0, height: 2 },
                      shadowOpacity: 0.04,
                      shadowRadius: 8,
                    }}
                  >
                    <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', marginBottom: 8, gap: 8 }}>
                      <Text style={{ fontSize: 15, fontWeight: '700', color: colors.ink, flexShrink: 1 }} numberOfLines={2}>
                        {concern.ingredient}
                      </Text>
                      <View style={{
                        backgroundColor: sConfig.bg,
                        borderRadius: 8,
                        paddingVertical: 4,
                        paddingHorizontal: 10,
                        borderWidth: 1,
                        borderColor: sConfig.borderColor,
                        flexShrink: 0,
                      }}>
                        <Text style={{ fontSize: 11, fontWeight: '600', color: sConfig.color, textTransform: 'capitalize' }}>
                          {concern.severity}
                        </Text>
                      </View>
                    </View>
                    <Text style={{ fontSize: 14, color: colors.inkSecondary, lineHeight: 20 }}>{concern.description}</Text>
                  </View>
                );
              })}
            </View>
          </View>
        )}

        {/* Positives */}
        {result.positives && result.positives.length > 0 && (
          <View style={{ paddingHorizontal: 20, marginBottom: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('result.positives')}
            </Text>
            <View style={{ gap: 8 }}>
              {result.positives.map((positive) => (
                <View key={positive} style={{
                  backgroundColor: colors.safeLight,
                  borderRadius: 12,
                  paddingVertical: 10,
                  paddingHorizontal: 14,
                  flexDirection: 'row',
                  alignItems: 'center',
                  borderWidth: 1,
                  borderColor: colors.safe,
                }}>
                  <Ionicons name="checkmark-circle" size={16} color={colors.safe} style={{ marginRight: 6, flexShrink: 0 }} />
                  <Text style={{ fontSize: 14, fontWeight: '600', color: colors.safe, flexShrink: 1 }}>{positive}</Text>
                </View>
              ))}
            </View>
          </View>
        )}

        {/* Better Alternatives */}
        {result.swaps && result.swaps.length > 0 && (
          <View style={{ paddingHorizontal: 20 }}>
            <Text style={{ fontSize: 13, fontWeight: '600', color: colors.inkSecondary, marginBottom: 14, letterSpacing: 0.5, textTransform: 'uppercase' }}>
              {t('result.betterAlternatives')}
            </Text>
            <View style={{ gap: 10 }}>
              {result.swaps.map((swap) => (
                <Pressable
                  key={swap.id}
                  style={{
                    backgroundColor: colors.glassSolid,
                    borderRadius: 20,
                    padding: 16,
                    flexDirection: 'row',
                    alignItems: 'center',
                    borderWidth: 1,
                    borderColor: colors.glassBorder,
                    shadowColor: '#000',
                    shadowOffset: { width: 0, height: 2 },
                    shadowOpacity: 0.04,
                    shadowRadius: 8,
                  }}
                >
                  <View style={{
                    width: 52,
                    height: 52,
                    borderRadius: 16,
                    backgroundColor: colors.safeLight,
                    alignItems: 'center',
                    justifyContent: 'center',
                    marginRight: 14,
                    borderWidth: 2,
                    borderColor: colors.safe,
                  }}>
                    <Text style={{ fontSize: 18, fontWeight: '800', color: colors.safe }}>{swap.score}</Text>
                  </View>
                  <View style={{ flex: 1 }}>
                    <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 2 }}>{swap.name}</Text>
                    <Text style={{ fontSize: 13, color: colors.inkSecondary }}>{swap.brand}</Text>
                  </View>
                  <View style={{
                    width: 36,
                    height: 36,
                    borderRadius: 12,
                    backgroundColor: colors.oxygenGlow,
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}>
                    <Ionicons name="arrow-forward" size={18} color={colors.oxygen} />
                  </View>
                </Pressable>
              ))}
            </View>
          </View>
        )}

        {/* Store-Aware Shopping Prompt */}
        {result.score < 67 && (
          <StorePrompt
            currentStore={usePreferencesStore.getState().preferredStore}
            onStoreSet={(store) => usePreferencesStore.getState().setPreferredStore(store)}
            onStoreClear={() => usePreferencesStore.getState().setPreferredStore(null)}
          />
        )}

        {/* Pipeline Debug Info */}
        {id === 'scan' && currentResult && (
          <PipelineDebug result={currentResult} />
        )}
      </ScrollView>

      {/* Bottom Actions */}
      <View style={{
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        backgroundColor: colors.glassSolid,
        paddingHorizontal: 20,
        paddingTop: 16,
        paddingBottom: 34,
        borderTopWidth: 1,
        borderTopColor: colors.glassBorder,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: -4 },
        shadowOpacity: 0.04,
        shadowRadius: 12,
      }}>
        <View style={{ flexDirection: 'row', gap: 12 }}>
          <Pressable style={{
            flex: 1,
            backgroundColor: colors.canvas,
            borderRadius: 16,
            paddingVertical: 16,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            borderWidth: 1,
            borderColor: colors.glassBorder,
          }}>
            <Ionicons name="heart-outline" size={20} color={colors.ink} />
            <Text style={{ fontSize: 16, fontWeight: '600', color: colors.ink, marginLeft: 8 }}>{t('result.save')}</Text>
          </Pressable>
          <Pressable
            style={{
              flex: 1,
              backgroundColor: colors.oxygen,
              borderRadius: 16,
              paddingVertical: 16,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              shadowColor: colors.oxygen,
              shadowOffset: { width: 0, height: 8 },
              shadowOpacity: 0.3,
              shadowRadius: 16,
            }}
            onPress={handleScanAgain}
          >
            <Ionicons name="scan-outline" size={20} color="white" />
            <Text style={{ fontSize: 16, fontWeight: '700', color: 'white', marginLeft: 8 }}>{t('result.scanAgain')}</Text>
          </Pressable>
        </View>
      </View>
    </SafeAreaView>
  );
}

// Pipeline Debug Component
function PipelineDebug({ result }: { result: any }) {
  const [expanded, setExpanded] = useState(false);
  const [textExpanded, setTextExpanded] = useState(false);
  const trace = result.pipelineTrace;

  const statusDot = (status: string) => {
    const color = status === 'success' ? colors.safe
      : status === 'failed' ? colors.toxic
      : colors.inkMuted;
    return (
      <View style={{
        width: 8,
        height: 8,
        borderRadius: 4,
        backgroundColor: color,
        marginRight: 8,
        marginTop: 4,
      }} />
    );
  };

  const ocrSourceLabel = (source: string) => {
    switch (source) {
      case 'device': return 'Device (ML Kit)';
      case 'cloud': return 'Google Cloud Vision';
      case 'ai-mini': return 'GPT-4o-mini';
      case 'ai-vision': return 'GPT-4o Vision';
      case 'manual': return t('pipeline.manual');
      default: return source;
    }
  };

  return (
    <View style={{ paddingHorizontal: 20, marginTop: 24 }}>
      <Pressable
        onPress={() => setExpanded(!expanded)}
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginBottom: 8,
        }}
      >
        <Text style={{ fontSize: 11, fontWeight: '600', color: colors.inkMuted, letterSpacing: 0.3, textTransform: 'uppercase' }}>
          Pipeline Details
        </Text>
        <View style={{ flexDirection: 'row', alignItems: 'center' }}>
          {trace?.totalDurationMs && (
            <Text style={{ fontSize: 11, color: colors.inkMuted, marginRight: 8 }}>
              {(trace.totalDurationMs / 1000).toFixed(1)}s
            </Text>
          )}
          <Ionicons
            name={expanded ? 'chevron-up' : 'chevron-down'}
            size={16}
            color={colors.inkMuted}
          />
        </View>
      </Pressable>

      {/* Summary (always visible) */}
      <View style={{
        backgroundColor: colors.glassSolid,
        borderRadius: 12,
        padding: 12,
        borderWidth: 1,
        borderColor: colors.glassBorder,
        gap: 6,
      }}>
        <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
          <Text style={{ fontSize: 12, color: colors.inkMuted }}>OCR Source:</Text>
          <Text style={{ fontSize: 12, color: colors.ink, fontWeight: '600' }}>
            {ocrSourceLabel(result.ocrSource)}
          </Text>
        </View>
        <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
          <Text style={{ fontSize: 12, color: colors.inkMuted }}>Analysis Model:</Text>
          <Text style={{ fontSize: 12, color: colors.ink, fontWeight: '600' }}>
            {result.cached ? 'Cached' : result.model}
          </Text>
        </View>
        {trace?.extractionModel && (
          <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
            <Text style={{ fontSize: 12, color: colors.inkMuted }}>Extraction Model:</Text>
            <Text style={{ fontSize: 12, color: colors.ink, fontWeight: '600' }}>
              {trace.extractionModel}
            </Text>
          </View>
        )}
      </View>

      {/* Expanded Details */}
      {expanded && trace && (
        <View style={{ marginTop: 10, gap: 10 }}>
          {/* Pipeline Steps */}
          {trace.steps?.length > 0 && (
            <View style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 12,
              padding: 12,
              borderWidth: 1,
              borderColor: colors.glassBorder,
            }}>
              <Text style={{ fontSize: 11, fontWeight: '600', color: colors.inkMuted, marginBottom: 8, textTransform: 'uppercase' }}>
                Steps
              </Text>
              {trace.steps.map((step: any, i: number) => (
                <View key={i} style={{
                  flexDirection: 'row',
                  alignItems: 'flex-start',
                  marginBottom: i < trace.steps.length - 1 ? 8 : 0,
                }}>
                  {statusDot(step.status)}
                  <View style={{ flex: 1 }}>
                    <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
                      <Text style={{ fontSize: 12, color: colors.ink, fontWeight: '600' }}>
                        {step.name}
                      </Text>
                      {step.durationMs > 0 && (
                        <Text style={{ fontSize: 11, color: colors.inkMuted }}>
                          {step.durationMs}ms
                        </Text>
                      )}
                    </View>
                    {step.detail && (
                      <Text style={{ fontSize: 11, color: colors.inkMuted, marginTop: 2 }}>
                        {step.detail}
                      </Text>
                    )}
                  </View>
                </View>
              ))}
            </View>
          )}

          {/* Extracted Text */}
          {trace.extractedText && (
            <View style={{
              backgroundColor: colors.glassSolid,
              borderRadius: 12,
              padding: 12,
              borderWidth: 1,
              borderColor: colors.glassBorder,
            }}>
              <Pressable
                onPress={() => setTextExpanded(!textExpanded)}
                style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}
              >
                <Text style={{ fontSize: 11, fontWeight: '600', color: colors.inkMuted, textTransform: 'uppercase' }}>
                  Extracted Text ({trace.extractedText.length} chars)
                </Text>
                <Ionicons
                  name={textExpanded ? 'chevron-up' : 'chevron-down'}
                  size={14}
                  color={colors.inkMuted}
                />
              </Pressable>
              <Text
                style={{ fontSize: 11, color: colors.ink, fontFamily: 'monospace', lineHeight: 16 }}
                numberOfLines={textExpanded ? undefined : 3}
              >
                {trace.extractedText}
              </Text>
            </View>
          )}
        </View>
      )}
    </View>
  );
}
