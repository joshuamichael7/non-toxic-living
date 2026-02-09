import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { getLocales } from 'expo-localization';
import i18n from '@/i18n';

export type SupportedLanguage = 'en' | 'es' | 'fr' | 'zh' | 'ja' | 'ko' | 'ar' | 'hi';

export const SUPPORTED_LANGUAGES: { code: SupportedLanguage; label: string; nativeLabel: string }[] = [
  { code: 'en', label: 'English', nativeLabel: 'English' },
  { code: 'es', label: 'Spanish', nativeLabel: 'Espa\u00f1ol' },
  { code: 'fr', label: 'French', nativeLabel: 'Fran\u00e7ais' },
  { code: 'zh', label: 'Chinese', nativeLabel: '\u4e2d\u6587' },
  { code: 'ja', label: 'Japanese', nativeLabel: '\u65e5\u672c\u8a9e' },
  { code: 'ko', label: 'Korean', nativeLabel: '\ud55c\uad6d\uc5b4' },
  { code: 'ar', label: 'Arabic', nativeLabel: '\u0627\u0644\u0639\u0631\u0628\u064a\u0629' },
  { code: 'hi', label: 'Hindi', nativeLabel: '\u0939\u093f\u0928\u094d\u0926\u0940' },
];

const SUPPORTED_CODES = SUPPORTED_LANGUAGES.map(l => l.code);

function getDefaultLanguage(): SupportedLanguage {
  try {
    const locales = getLocales();
    const deviceLang = locales[0]?.languageCode as SupportedLanguage;
    return SUPPORTED_CODES.includes(deviceLang) ? deviceLang : 'en';
  } catch {
    return 'en';
  }
}

interface PreferencesState {
  language: SupportedLanguage;
  setLanguage: (language: SupportedLanguage) => void;
}

export const usePreferencesStore = create<PreferencesState>()(
  persist(
    (set) => ({
      language: getDefaultLanguage(),
      setLanguage: (language) => {
        i18n.changeLanguage(language);
        set({ language });
      },
    }),
    {
      name: '@preferences',
      storage: createJSONStorage(() => AsyncStorage),
      onRehydrateStorage: () => (state) => {
        // Sync i18n language when store rehydrates from AsyncStorage
        if (state?.language) {
          i18n.changeLanguage(state.language);
        }
      },
    }
  )
);
