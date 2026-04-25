import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../presentation/screens/verify_code_screen.dart';

class ForgetPasswordController extends GetxController {
  final emailTextEditingController = TextEditingController();
  final isLoading = false.obs;

  bool get isValidEmail =>
      emailTextEditingController.text.trim().isNotEmpty &&
      GetUtils.isEmail(emailTextEditingController.text.trim());

  Future<void> forgetPassword({
    required String email,
    required String verifyType,
  }) async {
    if (email.isEmpty) {
      AppSnackBar.error("Please enter an email");
      return;
    }
    if (!isValidEmail) {
      AppSnackBar.error('Please enter a valid email');
      return;
    }

    isLoading.value = true;

    try {
      final response = await NetworkCaller().postRequest(
        AppUrls.forgetPassword,
        body: {'email': email},
      );

      if (response.isSuccess) {
        Get.to(() => VerifyCodeScreen(email: email, verifyType: verifyType));
        emailTextEditingController.clear();
        AppSnackBar.success('OTP sent to your email');
      }
    } catch (e) {
      AppSnackBar.success('Something went wrong. Please try again');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    super.onClose();
  }
}
