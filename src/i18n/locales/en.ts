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
  'result.saved': 'Saved!',
  'result.scanAgain': 'Scan Again',

  // Swap detail modal
  'swap.safetyScore': 'Safety Score',
  'swap.whyBetter': 'Why This Is Better',
  'swap.availableAt': 'Available At',
  'swap.shopNow': 'Shop Now',
  'swap.close': 'Close',

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
  'auth.name': 'Name',
  'auth.nameRequired': 'Name is required',
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
  'store.findAtStore': 'Find at a store',

  // Scan - No label option
  'scan.noLabel': 'No label? Describe it',

  // Describe screen
  'describe.title': 'Describe Product',
  'describe.productType': 'What type of product?',
  'describe.brand': 'Brand (optional)',
  'describe.brandPlaceholder': 'e.g., IKEA, Pottery Barn...',
  'describe.productName': 'Product name (optional)',
  'describe.productNamePlaceholder': 'e.g., KALLAX shelf, Memory foam mattress...',
  'describe.materials': 'What do you know about this product?',
  'describe.materialsPlaceholder': 'e.g., polyester, memory foam, BPA-free plastic, stainless steel, treated wood...',
  'describe.addPhoto': 'Add photo (optional)',
  'describe.removePhoto': 'Remove',
  'describe.analyze': 'Analyze Product',
  'describe.selectType': 'Please select a product type',
  'describe.type.food': 'Food & Drinks',
  'describe.type.furniture': 'Furniture',
  'describe.type.mattress': 'Mattress & Bedding',
  'describe.type.clothing': 'Clothing & Textiles',
  'describe.type.cookware': 'Cookware',
  'describe.type.toys': 'Toys',
  'describe.type.fragrance': 'Candles & Air',
  'describe.type.paint': 'Paint & Stain',
  'describe.type.garden': 'Garden & Yard',
  'describe.type.pet': 'Pet Products',
  'describe.type.storage': 'Food Storage',
  'describe.type.household': 'Other Household',

  // Pipeline debug - manual
  'pipeline.manual': 'Manual Description',

  // Search results
  'search.results': 'Results',
  'search.searching': 'Searching...',
  'search.noResults': 'No results found',
  'search.noResultsDesc': 'Try a different search term or browse categories',

  // History screen
  'history.title': 'Scan History',
  'history.all': 'All',
  'history.favorites': 'Favorites',
  'history.avoid': 'Avoid',
  'history.empty': 'No scans yet',
  'history.emptyDesc': 'Products you scan will appear here',
  'history.emptyFavorites': 'No favorites yet',
  'history.emptyFavoritesDesc': 'Save products you love to find them here',
  'history.emptyAvoid': 'No items to avoid',
  'history.emptyAvoidDesc': 'Products you want to avoid will appear here',

  // Notifications screen
  'notifications.title': 'Notifications',
  'notifications.productAlerts': 'Product Alerts',
  'notifications.productAlertsDesc': 'Get notified about recalls and safety updates',
  'notifications.scanReminders': 'Scan Reminders',
  'notifications.scanRemindersDesc': 'Reminders to scan products before buying',
  'notifications.ingredientWarnings': 'Ingredient Warnings',
  'notifications.ingredientWarningsDesc': 'Alerts about newly flagged ingredients',
  'notifications.weeklyReport': 'Weekly Report',
  'notifications.weeklyReportDesc': 'Summary of your scanning activity',

  // Help screen
  'help.title': 'Help & Support',
  'help.faq': 'Frequently Asked Questions',
  'help.faq1Q': 'How does the scanner work?',
  'help.faq1A': 'Point your camera at an ingredient label. Our AI reads the text and analyzes each ingredient for potential health concerns, giving you a safety score from 0-100.',
  'help.faq2Q': 'How accurate are the results?',
  'help.faq2A': 'Our analysis is based on scientific research and regulatory databases. While we strive for accuracy, always consult healthcare professionals for medical decisions.',
  'help.faq3Q': 'Can I scan products without a label?',
  'help.faq3A': 'Yes! Use the "No label? Describe it" option to manually describe products like furniture, cookware, or other items without ingredient lists.',
  'help.faq4Q': 'What do the scores mean?',
  'help.faq4A': '67-100 is Safe (green), 34-66 is Caution (yellow), and 0-33 is Avoid (red). The score considers ingredient toxicity, regulatory status, and potential health impacts.',
  'help.contact': 'Contact Us',
  'help.emailSupport': 'Email Support',
  'help.reportProblem': 'Report a Problem',
  'help.appFeedback': 'App Feedback',

  // About screen
  'about.title': 'About',
  'about.appName': 'Non-Toxic Living',
  'about.missionTitle': 'Our Mission',
  'about.mission': 'We believe everyone deserves to know what\'s in their products. Our mission is to make it easy to identify harmful ingredients and find safer alternatives for your family.',
  'about.privacyPolicy': 'Privacy Policy',
  'about.termsOfService': 'Terms of Service',
  'about.creditsDesc': 'Built with care for healthier living.\nPowered by AI and scientific research.',

  // Coupons
  'coupon.partnerDeal': 'PARTNER DEAL',
  'coupon.freeShipping': 'Free Shipping',
  'coupon.bogo': 'Buy One Get One',
  'coupon.expiresIn': '{{days}}d left',
  'coupon.redeem': 'Redeem Deal',
  'coupon.copied': 'Copied!',
  'coupon.deals': 'Deals & Discounts',

  // Deals
  'deals.title': 'Deals & Discounts',
  'deals.shopNow': 'Shop Now',
  'deals.showAtCheckout': 'Show at Checkout',
  'deals.useInStore': 'Use In Store',
  'deals.shopOnline': 'Shop Online',
  'deals.codeCopied': 'Code Copied!',

  // Featured
  'featured.title': 'Featured',
  'featured.learnMore': 'Learn More',
  'featured.shopNow': 'Shop Now',

  // Subscription
  'subscription.title': 'Choose Your Plan',
  'subscription.subtitle': 'Unlock more scans and premium features',
  'subscription.monthly': 'Monthly',
  'subscription.annual': 'Annual',
  'subscription.perMonth': '/month',
  'subscription.perYear': '/year',
  'subscription.subscribe': 'Subscribe',
  'subscription.current': 'Current',
  'subscription.currentPlan': '{{plan}} Plan',
  'subscription.goPremium': 'Go Premium',
  'subscription.goPremiumDesc': 'More scans, detailed reports & more',
  'subscription.managePlan': 'Manage Subscription',
  'subscription.restorePurchases': 'Restore Purchases',
  'subscription.restoring': 'Restoring...',
  'subscription.restored': 'Purchases restored!',
  'subscription.restoreNone': 'No previous purchases found',
  'subscription.cancelAnytime': 'Cancel anytime. Subscriptions auto-renew until cancelled.',
  'subscription.purchaseError': 'Purchase failed. Please try again.',
  'subscription.processing': 'Processing...',
  'subscription.oneMonthFree': '1 month free',

  // Tiers
  'tier.free': 'Free',
  'tier.pro': 'Pro',
  'tier.power': 'Power',
  'tier.freeDesc': 'Get started',
  'tier.proDesc': 'Most popular',
  'tier.powerDesc': 'For power users',

  // Features
  'feature.freeScans': '5 scans per month',
  'feature.basicAnalysis': 'Basic ingredient analysis',
  'feature.proScans': '200 scans per month',
  'feature.detailedReports': 'Detailed safety reports',
  'feature.prioritySupport': 'Priority support',
  'feature.powerScans': '500 scans per month',
  'feature.allProFeatures': 'Everything in Pro',
  'feature.familySharing': 'Family sharing',
  'feature.exportReports': 'Export scan reports',

  // Pricing fallbacks
  'price.free': 'Free',

  // Profile plan labels
  'profile.proPlan': 'Pro Plan',
  'profile.powerPlan': 'Power Plan',

  // Quota
  'quota.title': 'Scan Limit Reached',
  'quota.description': "You've used {{used}} of {{limit}} scans this month.",
  'quota.resetsIn': 'Resets in {{days}} days',
  'quota.upgradePro': 'Upgrade Now',
  'quota.dismiss': 'Maybe later',
  'quota.scanUsage': 'Scan Usage',
  'quota.scansThisMonth': 'scans this month',
  'quota.resetsOn': 'Resets {{date}}',
  'quota.upgradePrompt': 'Running low on scans?',
  'quota.upgrade': 'Upgrade',

  // Common
  'common.cancel': 'Cancel',
  'common.save': 'Save',
  'common.close': 'Close',
  'common.error': 'Error',
  'common.loading': 'Loading...',
} as const;
