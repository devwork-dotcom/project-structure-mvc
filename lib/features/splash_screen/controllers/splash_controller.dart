import 'package:get/get.dart';
import 'package:project_structure/core/utils/logging/logger.dart';
import 'package:project_structure/features/authentication/presentation/screens/login_screen.dart';
import 'package:project_structure/features/nav_bar/presentation/screens/nav_bar.dart';
import 'package:project_structure/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'dart:async';
import 'package:project_structure/core/services/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initAuthAndNavigate();
  }

  Future<void> initAuthAndNavigate() async {
    await AuthService.init();

    final token = AuthService.token;
    final userId = AuthService.userId;
    final rememberMe = AuthService.rememberMe;
    AppLoggerHelper.debug("Token : $token \n UserId : $userId");

    if (token != null &&
        token.isNotEmpty &&
        userId != null &&
        userId.isNotEmpty &&
        rememberMe == true) {
      Get.offAll(() => NavBar());
      return;
    }

    if (token != null &&
        token.isNotEmpty &&
        userId != null &&
        userId.isNotEmpty &&
        rememberMe == false) {
      Get.offAll(() => LoginScreen());
      return;
    }

    await Future.delayed(Duration(seconds: 3));
    Get.offAll(() => OnboardingScreen());
  }
}
