import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';

import '../../../core/common/widgets/app_toast.dart';

import '../../../core/common/widgets/loading_widgets.dart';
import 'package:project_structure/core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../../../routes/app_routes.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Observable booleans for password visibility
  final RxBool isCurrentPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  // Methods to toggle password visibility
  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  final RxBool isChangePasswordLoading = false.obs;
  Future<void> changePassword() async {
    if (currentPasswordController.text.isEmpty) {
      AppSnackBar.error('Current Password is Required');
      return;
    }

    if (newPasswordController.text.isEmpty) {
      AppSnackBar.error('Please Enter New Password');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      AppSnackBar.error('Please Enter Confirm Password');
      return;
    }
    if (newPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      AppSnackBar.error('Password and Confirm Password Not match.');
      return;
    }

    final Map<String, dynamic> body = {
      'oldPassword': currentPasswordController.text.trim(),
      'newPassword': newPasswordController.text.trim(),
    };

    try {
      isChangePasswordLoading(true);

      final response = await NetworkCaller().putRequest(
        AppUrls.changePassword,
        token: 'Bearer ${AuthService.token}',
        body: body,
      );

      final data = response.responseData ?? {};
      final success = data['success'] == true;
      final message =
          data['message'] ?? 'Failed to change password. Please try again.';

      if (success) {
        Get.back();
        AppSnackBar.success('Password changed successfully');
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else if (response.statusCode == 203) {
        AppSnackBar.error(
          "Current password is invalid. Please enter correct password.",
        );
      } else {
        AppSnackBar.error(message);
        AppLoggerHelper.error(
          'Failed to change password: ${response.statusCode} - $message',
        );
      }
    } catch (e) {
      AppSnackBar.error("Something went wrong. Please try agian later.");
      AppLoggerHelper.error(e.toString());
    } finally {
      isChangePasswordLoading(false);
    }
  }
}
