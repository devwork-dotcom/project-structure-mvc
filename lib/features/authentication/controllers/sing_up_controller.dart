import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/logging/logger.dart';
import '../presentation/screens/verify_code_screen.dart';

class SignUpController extends GetxController {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  final RxBool isPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isAgree = false.obs;

  String fcmToken = '';

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleComPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signUp({
    required String email,
    required String verifyType,
  }) async {
    // Name validation
    if (nameTEController.text.trim().isEmpty) {
      AppSnackBar.error('Please enter your name.');
      return;
    }

    // Email validation
    if (emailTEController.text.trim().isEmpty) {
      AppSnackBar.error('Please enter your email.');
      return;
    }

    // Password validation
    if (passwordTEController.text.trim().isEmpty) {
      AppSnackBar.error('Please enter your password.');
      return;
    }

    // Confirm password validation
    if (confirmPasswordTEController.text.trim().isEmpty) {
      AppSnackBar.error('Please confirm your password.');
      return;
    }

    // Password match validation
    if (passwordTEController.text.trim() !=
        confirmPasswordTEController.text.trim()) {
      AppSnackBar.error("Password and confirm password do not match.");
      return;
    }

    // Agree checkbox validation (FIXED)
    if (!isAgree.value) {
      AppSnackBar.error("Please accept terms and conditions.");
      return;
    }

    isLoading.value = true;

    try {
      final Map<String, dynamic> requestBody = {
        "name": nameTEController.text.trim(),
        "email": emailTEController.text.trim(),
        "password": passwordTEController.text.trim(),
      };

      log('SignUp Request Body: $requestBody');

      final response = await NetworkCaller().postRequest(
        AppUrls.register,
        body: requestBody,
      );

      log("SignUp API Response: ${response.responseData}");

      if (response.isSuccess) {
        Get.to(() => VerifyCodeScreen(email: email, verifyType: verifyType));
      } else if (response.statusCode == 404) {
        AppSnackBar.error(
          'Email already exists. Please login or try different email.',
        );
      } else {
        AppSnackBar.error(response.errorMessage);
      }
    } catch (e) {
      AppLoggerHelper.error('SignUp Error: $e');
      AppSnackBar.error(
        e.toString().contains('TimeoutException')
            ? 'Request timed out. Check your internet connection.'
            : 'Something went wrong! Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
