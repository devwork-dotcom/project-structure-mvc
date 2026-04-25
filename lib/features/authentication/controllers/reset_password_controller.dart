import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/services/network_caller.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/core/utils/logging/logger.dart';
import 'package:project_structure/features/authentication/presentation/screens/login_screen.dart';
import 'package:project_structure/features/authentication/presentation/widgets/sign_up_confirmation_dialog.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();
  final RxBool isPasswordVisible = true.obs;
  final RxBool isComPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleComPasswordVisibility() {
    isComPasswordVisible.value = !isComPasswordVisible.value;
  }

  final RxBool isLoading = false.obs;

  /// Reset Password
  Future<void> resetPassword({required String token}) async {
    if (passwordTEController.text.isEmpty) {
      AppSnackBar.error('Please enter password.');
      return;
    }
    if (confirmPasswordTEController.text.isEmpty) {
      AppSnackBar.error('Please enter confirm password.');
      return;
    }

    if (passwordTEController.text != confirmPasswordTEController.text) {
      AppSnackBar.error('Passwords do not match.');
      return;
    }

    final Map<String, dynamic> requestBody = {
      "token": token,
      'password': passwordTEController.text.trim(),
    };
    try {
      isLoading(true);
      final response = await NetworkCaller().postRequest(
        AppUrls.resetPassword,
        body: requestBody,
      );

      if (response.isSuccess) {
        passwordTEController.clear();
        confirmPasswordTEController.clear();
        showSignupConfirmationDialog(
          image: IconPath.success,
          title: "Success",
          subTitle: "You’re Back on Track  Your password has been updated",
          butonText: "Go Login",
          onTap: () {
            Get.to(() => LoginScreen());
          },
        );

        log("request $requestBody");
      } else {
        AppSnackBar.error(response.errorMessage);
      }
    } catch (e) {
      AppSnackBar.error("Something went wrong. Try again later.");
      AppLoggerHelper.error('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
