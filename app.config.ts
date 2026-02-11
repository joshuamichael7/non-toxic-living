import { ExpoConfig, ConfigContext } from 'expo/config';

// Auto-increment build number based on date + time
// Format: YYYYMMDDNN where NN = hours*2 + minutes/30
// This guarantees a monotonically increasing number for each build
const now = new Date();
const datePart = now.toISOString().slice(0, 10).replace(/-/g, '');
const timePart = String(now.getHours() * 2 + Math.floor(now.getMinutes() / 30)).padStart(2, '0');
const buildNumber = `${datePart}${timePart}`;

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'NoTox',
  slug: 'non-toxic-living',
  version: '1.0.0',
  orientation: 'portrait',
  icon: './assets/images/icon.png',
  scheme: 'nontoxicliving',
  userInterfaceStyle: 'automatic',
  newArchEnabled: true,
  splash: {
    image: './assets/images/splash-icon.png',
    resizeMode: 'contain',
    backgroundColor: '#0EA5E9',
  },
  ios: {
    supportsTablet: true,
    bundleIdentifier: 'com.nontoxicliving.app',
    buildNumber,
    infoPlist: {
      NSCameraUsageDescription:
        'Non-Toxic Living needs camera access to scan products and ingredients for toxicity analysis.',
      ITSAppUsesNonExemptEncryption: false,
    },
  },
  android: {
    adaptiveIcon: {
      foregroundImage: './assets/images/adaptive-icon.png',
      backgroundColor: '#0EA5E9',
    },
    package: 'com.nontoxicliving.app',
    permissions: ['android.permission.CAMERA'],
  },
  web: {
    bundler: 'metro',
    output: 'static' as const,
    favicon: './assets/images/favicon.png',
  },
  plugins: [
    'expo-router',
    [
      'expo-camera',
      {
        cameraPermission:
          'Allow Non-Toxic Living to access your camera to scan products.',
      },
    ],
    'expo-localization',
  ],
  experiments: {
    typedRoutes: true,
  },
});
