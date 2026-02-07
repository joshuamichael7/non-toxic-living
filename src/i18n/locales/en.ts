export default {
  // Tab navigation
  'tab.home': 'Home',
  'tab.scan': 'Scan',
  'tab.search': 'Search',
  'tab.profile': 'Profile',

  // Home screen
  'home.welcome': 'Welcome back',
  'home.scanAnything': 'Scan Anything',
  'home.toxinScanner': 'Toxin Scanner',
  'home.subtitle': "What's in your\nproducts?",
  'home.description': 'Point your camera at any ingredient label for instant analysis',
  'home.startScanning': 'Start Scanning',
  'home.categories': 'Categories',
  'home.insights': 'Insights',
  'home.recentScans': 'Recent Scans',
  'home.seeAll': 'See all',

  // Categories
  'category.food': 'Food',
  'category.personalCare': 'Personal Care',
  'category.household': 'Household',
  'category.baby': 'Baby',
  'category.cookware': 'Cookware',
  'category.foodDrinks': 'Food & Drinks',
  'category.babyKids': 'Baby & Kids',
  'category.cleaning': 'Cleaning',

  // Insights
  'insight.didYouKnow': 'Did you know?',
  'insight.didYouKnowDesc': '98% of non-stick pans contain PFAS, linked to hormone disruption.',
  'insight.tipOfDay': 'Tip of the day',
  'insight.tipOfDayDesc': "Check for 'fragrance' in products - it can hide hundreds of chemicals.",
  'insight.trendingConcern': 'Trending concern',
  'insight.trendingConcernDesc': 'Titanium dioxide is now banned in EU food products.',

  // Scan screen
  'scan.title': 'Scan a Product',
  'scan.subtitle': "Take a photo of the ingredient label and we'll analyze it for toxins",
  'scan.openCamera': 'Open Camera',
  'scan.tip': 'Tip: Focus on the ingredient list for the most accurate results',
  'scan.reading': 'Reading label...',
  'scan.analyzing': 'Analyzing...',
  'scan.extracting': 'Extracting text from image',
  'scan.checking': 'Checking ingredients for toxins',

  // Search screen
  'search.title': 'Search',
  'search.subtitle': 'Find safe alternatives for any product',
  'search.placeholder': 'Search products or ingredients...',
  'search.categories': 'Categories',
  'search.popularSearches': 'Popular Searches',
  'search.nonToxicSunscreen': 'Non-toxic sunscreen',
  'search.safeCookware': 'Safe cookware',
  'search.cleanShampoo': 'Clean shampoo',
  'search.organicSnacks': 'Organic snacks',
  'search.pfasFree': 'PFAS-free products',
  'search.naturalDeodorant': 'Natural deodorant',

  // Profile screen
  'profile.title': 'Profile',
  'profile.guestUser': 'Guest User',
  'profile.freePlan': 'Free Plan',
  'profile.scans': 'Scans',
  'profile.toxinsAvoided': 'Toxins Avoided',
  'profile.dayStreak': 'Day Streak',
  'profile.goPremium': 'Go Premium',
  'profile.premiumDesc': 'Unlimited scans, detailed reports & more',
  'profile.myFavorites': 'My Favorites',
  'profile.avoidList': 'Avoid List',
  'profile.scanHistory': 'Scan History',
  'profile.language': 'Language',
  'profile.notifications': 'Notifications',
  'profile.helpSupport': 'Help & Support',
  'profile.about': 'About',
  'profile.exportLogs': 'Export Scan Logs',
  'profile.version': 'Version {{version}}',
  'profile.signOut': 'Sign Out',

  // Result screen
  'result.title': 'Analysis Result',
  'result.cached': 'Instant Result from Database',
  'result.summary': 'Summary',
  'result.expertTake': 'Expert Take',
  'result.concerns': 'Concerns ({{count}})',
  'result.positives': 'Positives',
  'result.betterAlternatives': 'Better Alternatives',
  'result.save': 'Save',
  'result.scanAgain': 'Scan Again',

  // Verdicts
  'verdict.safe': 'Safe',
  'verdict.caution': 'Caution',
  'verdict.toxic': 'Avoid',

  // Severity
  'severity.low': 'Low',
  'severity.medium': 'Medium',
  'severity.high': 'High',

  // Pipeline debug
  'pipeline.title': 'Pipeline Details',
  'pipeline.ocrSource': 'OCR Source:',
  'pipeline.analysisModel': 'Analysis Model:',
  'pipeline.extractionModel': 'Extraction Model:',
  'pipeline.steps': 'Steps',
  'pipeline.extractedText': 'Extracted Text ({{count}} chars)',
  'pipeline.deviceMlKit': 'Device (ML Kit)',
  'pipeline.cloudVision': 'Google Cloud Vision',
  'pipeline.gpt4oMini': 'GPT-4o-mini',
  'pipeline.gpt4oVision': 'GPT-4o Vision',
  'pipeline.cached': 'Cached',

  // Stats card
  'stats.toxinsAvoided': 'Concerns',
  'stats.thisWeek': 'Scans',
  'stats.dayStreak': 'Day Streak',
  'stats.safeFound': 'Safe',

  // Recent scans
  'recentScans.noScans': 'No scans yet',
  'recentScans.noScansDesc': 'Start scanning products to see your history here',

  // Auth
  'auth.signIn': 'Sign In',
  'auth.signUp': 'Sign Up',
  'auth.email': 'Email',
  'auth.password': 'Password',
  'auth.confirmPassword': 'Confirm Password',
  'auth.forgotPassword': 'Forgot Password?',
  'auth.noAccount': "Don't have an account?",
  'auth.hasAccount': 'Already have an account?',
  'auth.signInError': 'Invalid email or password',
  'auth.signUpError': 'Could not create account',
  'auth.emailRequired': 'Email is required',
  'auth.passwordRequired': 'Password is required',
  'auth.passwordMismatch': 'Passwords do not match',
  'auth.passwordMinLength': 'Password must be at least 6 characters',
  'auth.checkEmail': 'Check your email for a confirmation link',

  // Language picker
  'language.title': 'Language',
  'language.select': 'Select Language',

  // Not found
  'notFound.title': 'Page Not Found',
  'notFound.description': "The page you're looking for doesn't exist.",
  'notFound.goHome': 'Go Home',

  // Store selection
  'store.prompt': 'Shopping somewhere specific?',
  'store.promptDesc': 'We can find safer alternatives at your store',
  'store.inputPlaceholder': 'Enter store name...',
  'store.save': 'Save',
  'store.change': 'Change',
  'store.shoppingAt': 'Shopping at {{store}}',
  'store.clear': 'Clear',

  // Common
  'common.cancel': 'Cancel',
  'common.save': 'Save',
  'common.close': 'Close',
  'common.error': 'Error',
  'common.loading': 'Loading...',
} as const;
