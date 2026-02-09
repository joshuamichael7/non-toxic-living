import React, { useState } from 'react';
import { View, Text, Pressable, ScrollView, Linking, StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useRouter } from 'expo-router';
import { useTranslation } from 'react-i18next';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
};

const faqItems: {
  questionKey: string;
  answerKey: string;
}[] = [
  { questionKey: 'help.faq1Q', answerKey: 'help.faq1A' },
  { questionKey: 'help.faq2Q', answerKey: 'help.faq2A' },
  { questionKey: 'help.faq3Q', answerKey: 'help.faq3A' },
  { questionKey: 'help.faq4Q', answerKey: 'help.faq4A' },
];

const contactLinks: {
  icon: keyof typeof Ionicons.glyphMap;
  labelKey: string;
  url: string;
}[] = [
  {
    icon: 'mail-outline',
    labelKey: 'help.emailSupport',
    url: 'mailto:support@nontoxicliving.app',
  },
  {
    icon: 'bug-outline',
    labelKey: 'help.reportProblem',
    url: 'mailto:support@nontoxicliving.app?subject=Bug Report',
  },
  {
    icon: 'chatbubble-outline',
    labelKey: 'help.appFeedback',
    url: 'mailto:feedback@nontoxicliving.app?subject=App Feedback',
  },
];

export default function HelpScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const [expanded, setExpanded] = useState<Set<number>>(new Set());

  const toggleFaq = (index: number) => {
    setExpanded((prev) => {
      const next = new Set(prev);
      if (next.has(index)) {
        next.delete(index);
      } else {
        next.add(index);
      }
      return next;
    });
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Pressable onPress={() => router.back()} hitSlop={12}>
          <Ionicons name="close" size={28} color={colors.ink} />
        </Pressable>
        <Text style={styles.headerTitle}>{t('help.title')}</Text>
        <View style={{ width: 28 }} />
      </View>

      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* FAQ Section */}
        <Text style={styles.sectionHeader}>{t('help.faq')}</Text>

        <View style={styles.card}>
          {faqItems.map((item, index) => (
            <View key={index}>
              {index > 0 && <View style={styles.separator} />}
              <Pressable
                style={styles.faqRow}
                onPress={() => toggleFaq(index)}
              >
                <Text style={styles.faqQuestion}>{t(item.questionKey)}</Text>
                <Ionicons
                  name={expanded.has(index) ? 'chevron-up' : 'chevron-down'}
                  size={20}
                  color={colors.inkMuted}
                />
              </Pressable>
              {expanded.has(index) && (
                <View style={styles.faqAnswerContainer}>
                  <Text style={styles.faqAnswer}>{t(item.answerKey)}</Text>
                </View>
              )}
            </View>
          ))}
        </View>

        {/* Contact Section */}
        <Text style={styles.sectionHeader}>{t('help.contact')}</Text>

        {contactLinks.map((link, index) => (
          <Pressable
            key={index}
            style={styles.contactCard}
            onPress={() => Linking.openURL(link.url)}
          >
            <View style={styles.contactIconContainer}>
              <Ionicons name={link.icon} size={22} color={colors.oxygen} />
            </View>
            <Text style={styles.contactLabel}>{t(link.labelKey)}</Text>
            <Ionicons
              name="chevron-forward"
              size={18}
              color={colors.inkMuted}
            />
          </Pressable>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.canvas,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: colors.ink,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: 20,
    paddingBottom: 100,
  },
  sectionHeader: {
    fontSize: 12,
    fontWeight: '700',
    color: colors.inkSecondary,
    textTransform: 'uppercase',
    letterSpacing: 1,
    marginBottom: 12,
    marginTop: 24,
    marginLeft: 4,
  },
  card: {
    backgroundColor: colors.glassSolid,
    borderRadius: 24,
    borderWidth: 1,
    borderColor: colors.glassBorder,
    padding: 8,
  },
  separator: {
    height: 1,
    backgroundColor: colors.glassBorder,
    marginHorizontal: 12,
  },
  faqRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
  },
  faqQuestion: {
    fontSize: 15,
    fontWeight: '600',
    color: colors.ink,
    flex: 1,
    marginRight: 12,
  },
  faqAnswerContainer: {
    paddingHorizontal: 16,
    paddingBottom: 16,
    paddingTop: 0,
  },
  faqAnswer: {
    fontSize: 14,
    color: colors.inkSecondary,
    lineHeight: 21,
  },
  contactCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.glassSolid,
    borderRadius: 24,
    borderWidth: 1,
    borderColor: colors.glassBorder,
    padding: 16,
    marginBottom: 10,
  },
  contactIconContainer: {
    width: 40,
    height: 40,
    backgroundColor: colors.canvas,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 14,
  },
  contactLabel: {
    flex: 1,
    fontSize: 16,
    fontWeight: '600',
    color: colors.ink,
  },
});
