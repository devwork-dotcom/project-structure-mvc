class AppUrls {
  AppUrls._();

  ///Local Server
  static const String _baseUrl = 'http://10.0.20.155:7072/api/v1';

  /// User Api
  static const String register = '$_baseUrl/user/create';
  static const String getProfile = '$_baseUrl/user/profile';
  static const String updateProfile = '$_baseUrl/user/profile';
  static const String changePassword = '$_baseUrl/user/change-password';

  ///Auth API
  static const String login = '$_baseUrl/auth/login';
  static const String socialAuth = '$_baseUrl/auth/social';
  static const String verifyOtp = '$_baseUrl/auth/verify-otp';
  static const String resendOtp = '$_baseUrl/auth/resend-otp';
  static const String forgetPassword = '$_baseUrl/auth/forget-password';
  static const String resetPassword = '$_baseUrl/auth/reset-password';

  static const String verifyForgetPasswordOtp = '$_baseUrl/auth/verify-otp';
  static const String updateLocation = '$_baseUrl/auth/update/user-location';

  ///Hydration API
  static const String addHydration = '$_baseUrl/hydration/add';
  static const String getHydration = '$_baseUrl/hydration/weekly';

  ///Fitness Flow
  static const String createWorkout = '$_baseUrl/workout/create';
  static const String getSingleWorkout = '$_baseUrl/workout/single';
  static const String updateWorkout = '$_baseUrl/workout/update';
  static const String getMyWorkout = '$_baseUrl/workout/all';
  static const String deleteWorkout = '$_baseUrl/workout/delete';
  static const String getWeeklyWorkout = '$_baseUrl/workout/duration/weekly';
  static const String markDoneWorkout = '$_baseUrl/workout//duration';
  static const String getPremiumWorkout = '$_baseUrl/workout/paid';

  static const String addExercise = '$_baseUrl/workout/exercise/add';
  static const String updateExercise = '$_baseUrl/workout/exercise/update';
  static const String deleteExercise = '$_baseUrl/workout/exercise/delete';

  ///Nutrition API
  static const String createMyMeal = '$_baseUrl/meal/create';
  static const String getMyMeal = '$_baseUrl/meal/all';
  static const String updateMyMeal = '$_baseUrl/meal/update';
  static const String deleteMyMeal = '$_baseUrl/meal/delete';
  static const String getMealDetail = '$_baseUrl/meal/single';
  static const String getDailySummary = '$_baseUrl/meal/daily-summary';
  static const String dailyTaken = '$_baseUrl/meal/add-to-daily-intake';
  static const String addToMyMeal = '$_baseUrl/meal/add-to-my-meal';
  static const String markAsCooked = '$_baseUrl/meal/mark-as-cooked';

  static const String getPaidMeal = '$_baseUrl/meal/paid-meals';

  /// get Api
  static const String getUserProfile = '$_baseUrl/auth/profile';
  static const String getMindSetVerse = '$_baseUrl/verse/daily';
  static const String getAllReflection = '$_baseUrl/verse/my-reflection';

  ///Profile API
  static const String getTermsAndCondition = '$_baseUrl/terms/get';
  static const String getPrivacyAndPolicy = '$_baseUrl/terms/get';
  static const String getFaq = '$_baseUrl/faq/all?category=General Questions';

  ///Post Api
  static String addReflection(String verseId) =>
      '$_baseUrl/verse/reflection/$verseId';

  /// Web socket URL[chat]
  static const String connectSocket = "ws://206.162.244.146:7008";

  static const String generateImageLink = "$_baseUrl/chat/generateFile";
  static const String getMyChatLists = "$_baseUrl/chat/getMyChat";

  /// In app purchase
  static const String sendInAppPurchaseData = '$_baseUrl/subscription';
  static const String deleteUserProfile = '$_baseUrl/auth/profile';
}
