import { useState, useMemo } from 'react';
import { View, Text, Pressable, TextInput, FlatList } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import { COMMON_STORES } from '@/constants/stores';

const colors = {
  canvas: '#E8E8E8',
  glassSolid: '#F0F0F0',
  glassBorder: 'rgba(255, 255, 255, 0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14, 165, 233, 0.3)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
};

interface StorePromptProps {
  currentStore: string | null;
  onStoreSet: (store: string) => void;
  onStoreClear: () => void;
}

export function StorePrompt({ currentStore, onStoreSet, onStoreClear }: StorePromptProps) {
  const { t } = useTranslation();
  const [isExpanded, setIsExpanded] = useState(false);
  const [inputValue, setInputValue] = useState('');

  const filteredStores = useMemo(() => {
    if (!inputValue.trim()) return [];
    const query = inputValue.toLowerCase();
    return COMMON_STORES.filter(s => s.toLowerCase().includes(query)).slice(0, 5);
  }, [inputValue]);

  const handleSave = () => {
    const store = inputValue.trim();
    if (store) {
      onStoreSet(store);
      setIsExpanded(false);
      setInputValue('');
    }
  };

  const handleSelect = (store: string) => {
    onStoreSet(store);
    setIsExpanded(false);
    setInputValue('');
  };

  // Compact chip when store is already set
  if (currentStore && !isExpanded) {
    return (
      <View style={{ paddingHorizontal: 20, marginTop: 16 }}>
        <View style={{
          flexDirection: 'row',
          alignItems: 'center',
          backgroundColor: colors.oxygenGlow,
          borderRadius: 12,
          paddingVertical: 10,
          paddingHorizontal: 14,
        }}>
          <Ionicons name="storefront-outline" size={16} color={colors.oxygen} />
          <Text style={{ fontSize: 14, color: colors.oxygen, fontWeight: '600', marginLeft: 8, flex: 1 }}>
            {t('store.shoppingAt', { store: currentStore })}
          </Text>
          <Pressable onPress={() => { setIsExpanded(true); setInputValue(currentStore); }} hitSlop={8}>
            <Text style={{ fontSize: 13, color: colors.oxygen, fontWeight: '500' }}>{t('store.change')}</Text>
          </Pressable>
          <Text style={{ color: colors.inkMuted, marginHorizontal: 6 }}>|</Text>
          <Pressable onPress={onStoreClear} hitSlop={8}>
            <Text style={{ fontSize: 13, color: colors.inkMuted, fontWeight: '500' }}>{t('store.clear')}</Text>
          </Pressable>
        </View>
      </View>
    );
  }

  // Collapsed prompt (no store set, not expanded)
  if (!isExpanded) {
    return (
      <View style={{ paddingHorizontal: 20, marginTop: 16 }}>
        <Pressable
          onPress={() => setIsExpanded(true)}
          style={{
            backgroundColor: colors.glassSolid,
            borderRadius: 16,
            padding: 16,
            flexDirection: 'row',
            alignItems: 'center',
            borderWidth: 1,
            borderColor: colors.glassBorder,
          }}
        >
          <View style={{
            width: 40,
            height: 40,
            borderRadius: 12,
            backgroundColor: colors.oxygenGlow,
            alignItems: 'center',
            justifyContent: 'center',
            marginRight: 12,
          }}>
            <Ionicons name="storefront-outline" size={20} color={colors.oxygen} />
          </View>
          <View style={{ flex: 1 }}>
            <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink }}>
              {t('store.prompt')}
            </Text>
            <Text style={{ fontSize: 13, color: colors.inkSecondary, marginTop: 2 }}>
              {t('store.promptDesc')}
            </Text>
          </View>
          <Ionicons name="chevron-forward" size={18} color={colors.inkMuted} />
        </Pressable>
      </View>
    );
  }

  // Expanded input
  return (
    <View style={{ paddingHorizontal: 20, marginTop: 16 }}>
      <View style={{
        backgroundColor: colors.glassSolid,
        borderRadius: 16,
        padding: 16,
        borderWidth: 1,
        borderColor: colors.oxygen,
      }}>
        <Text style={{ fontSize: 15, fontWeight: '600', color: colors.ink, marginBottom: 12 }}>
          {t('store.prompt')}
        </Text>
        <View style={{ flexDirection: 'row', gap: 10 }}>
          <TextInput
            value={inputValue}
            onChangeText={setInputValue}
            placeholder={t('store.inputPlaceholder')}
            placeholderTextColor={colors.inkMuted}
            autoFocus
            returnKeyType="done"
            onSubmitEditing={handleSave}
            style={{
              flex: 1,
              backgroundColor: colors.canvas,
              borderRadius: 12,
              paddingHorizontal: 14,
              paddingVertical: 12,
              fontSize: 15,
              color: colors.ink,
              borderWidth: 1,
              borderColor: colors.glassBorder,
            }}
          />
          <Pressable
            onPress={handleSave}
            style={({ pressed }) => ({
              backgroundColor: pressed ? '#0284C7' : colors.oxygen,
              borderRadius: 12,
              paddingHorizontal: 16,
              justifyContent: 'center',
            })}
          >
            <Text style={{ color: 'white', fontWeight: '600', fontSize: 14 }}>{t('store.save')}</Text>
          </Pressable>
        </View>
        {/* Autocomplete suggestions */}
        {filteredStores.length > 0 && (
          <View style={{ marginTop: 8, gap: 4 }}>
            {filteredStores.map((store) => (
              <Pressable
                key={store}
                onPress={() => handleSelect(store)}
                style={({ pressed }) => ({
                  backgroundColor: pressed ? colors.oxygenGlow : colors.canvas,
                  borderRadius: 10,
                  paddingVertical: 10,
                  paddingHorizontal: 14,
                })}
              >
                <Text style={{ fontSize: 14, color: colors.ink }}>{store}</Text>
              </Pressable>
            ))}
          </View>
        )}
        <Pressable
          onPress={() => { setIsExpanded(false); setInputValue(''); }}
          style={{ marginTop: 10, alignSelf: 'center' }}
          hitSlop={8}
        >
          <Text style={{ fontSize: 13, color: colors.inkMuted }}>{t('common.cancel')}</Text>
        </Pressable>
      </View>
    </View>
  );
}
