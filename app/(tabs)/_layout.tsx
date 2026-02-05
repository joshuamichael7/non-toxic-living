import { Tabs } from 'expo-router';
import { View } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

type TabIconProps = {
  name: keyof typeof Ionicons.glyphMap;
  color: string;
  focused: boolean;
};

function TabIcon({ name, color, focused }: TabIconProps) {
  return (
    <View className={`items-center justify-center ${focused ? 'opacity-100' : 'opacity-60'}`}>
      <Ionicons name={name} size={24} color={color} />
    </View>
  );
}

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: '#059669',
        tabBarInactiveTintColor: '#A8A29E',
        tabBarStyle: {
          backgroundColor: 'rgba(255, 255, 255, 0.95)',
          borderTopWidth: 0,
          elevation: 0,
          shadowOpacity: 0.1,
          shadowRadius: 10,
          shadowOffset: { width: 0, height: -4 },
          height: 85,
          paddingTop: 10,
          paddingBottom: 25,
          position: 'absolute',
          bottom: 0,
          left: 0,
          right: 0,
        },
        tabBarLabelStyle: {
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: '500',
        },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
          tabBarIcon: ({ color, focused }) => (
            <TabIcon name="home-outline" color={color} focused={focused} />
          ),
        }}
      />
      <Tabs.Screen
        name="scan"
        options={{
          title: 'Scan',
          tabBarIcon: ({ color, focused }) => (
            <TabIcon name="scan-outline" color={color} focused={focused} />
          ),
        }}
      />
      <Tabs.Screen
        name="search"
        options={{
          title: 'Search',
          tabBarIcon: ({ color, focused }) => (
            <TabIcon name="search-outline" color={color} focused={focused} />
          ),
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: 'Profile',
          tabBarIcon: ({ color, focused }) => (
            <TabIcon name="person-outline" color={color} focused={focused} />
          ),
        }}
      />
    </Tabs>
  );
}
