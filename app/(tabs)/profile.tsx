import { View, Text, ScrollView, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const MENU_ITEMS = [
  { title: 'My Favorites', icon: 'heart-outline', badge: 12 },
  { title: 'Avoid List', icon: 'close-circle-outline', badge: 8 },
  { title: 'Scan History', icon: 'time-outline' },
  { title: 'Preferences', icon: 'options-outline' },
  { title: 'Notifications', icon: 'notifications-outline' },
  { title: 'Help & Support', icon: 'help-circle-outline' },
  { title: 'About', icon: 'information-circle-outline' },
];

export default function ProfileScreen() {
  return (
    <SafeAreaView className="flex-1 bg-stone-50" edges={['top']}>
      <ScrollView
        className="flex-1"
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View className="px-6 pt-4 pb-6">
          <Text className="text-2xl font-bold text-stone-900">Profile</Text>
        </View>

        {/* Profile Card */}
        <View className="px-6 mb-6">
          <View className="bg-white rounded-2xl p-6 shadow-sm">
            <View className="flex-row items-center mb-4">
              <View className="w-16 h-16 bg-primary/10 rounded-full items-center justify-center">
                <Ionicons name="person" size={32} color="#059669" />
              </View>
              <View className="ml-4 flex-1">
                <Text className="text-lg font-semibold text-stone-900">
                  Guest User
                </Text>
                <Text className="text-stone-500">Free Plan</Text>
              </View>
              <Pressable className="bg-primary rounded-lg px-4 py-2">
                <Text className="text-white font-medium">Sign In</Text>
              </Pressable>
            </View>

            {/* Stats */}
            <View className="flex-row border-t border-stone-100 pt-4">
              <View className="flex-1 items-center">
                <Text className="text-2xl font-bold text-primary">24</Text>
                <Text className="text-stone-500 text-sm">Scans</Text>
              </View>
              <View className="flex-1 items-center border-x border-stone-100">
                <Text className="text-2xl font-bold text-safe">18</Text>
                <Text className="text-stone-500 text-sm">Toxins Avoided</Text>
              </View>
              <View className="flex-1 items-center">
                <Text className="text-2xl font-bold text-caution">5</Text>
                <Text className="text-stone-500 text-sm">Day Streak</Text>
              </View>
            </View>
          </View>
        </View>

        {/* Premium Banner */}
        <View className="px-6 mb-6">
          <Pressable className="bg-gradient-to-r from-primary to-safe rounded-2xl p-5 flex-row items-center">
            <View className="flex-1">
              <Text className="text-white font-bold text-lg">Go Premium</Text>
              <Text className="text-white/80 text-sm mt-1">
                Unlimited scans, detailed reports & more
              </Text>
            </View>
            <View className="bg-white/20 rounded-full p-2">
              <Ionicons name="arrow-forward" size={24} color="white" />
            </View>
          </Pressable>
        </View>

        {/* Menu Items */}
        <View className="px-6">
          <View className="bg-white rounded-2xl overflow-hidden shadow-sm">
            {MENU_ITEMS.map((item, index) => (
              <Pressable
                key={item.title}
                className={`flex-row items-center p-4 ${
                  index < MENU_ITEMS.length - 1 ? 'border-b border-stone-100' : ''
                }`}
              >
                <View className="w-10 h-10 bg-stone-100 rounded-full items-center justify-center">
                  <Ionicons name={item.icon as any} size={20} color="#57534E" />
                </View>
                <Text className="flex-1 ml-3 text-stone-900 font-medium">
                  {item.title}
                </Text>
                {item.badge && (
                  <View className="bg-primary/10 rounded-full px-2 py-1 mr-2">
                    <Text className="text-primary text-sm font-medium">
                      {item.badge}
                    </Text>
                  </View>
                )}
                <Ionicons name="chevron-forward" size={20} color="#A8A29E" />
              </Pressable>
            ))}
          </View>
        </View>

        {/* App Version */}
        <View className="px-6 mt-6 items-center">
          <Text className="text-stone-400 text-sm">Version 1.0.0</Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}
