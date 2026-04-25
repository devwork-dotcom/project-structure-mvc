import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/core/utils/constants/enums.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/authentication/presentation/screens/login_screen.dart';
import 'package:project_structure/features/authentication/presentation/screens/reset_password_screen.dart';
import '../../../core/common/widgets/app_toast.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../presentation/widgets/sign_up_confirmation_dialog.dart';

class OtpController extends GetxController {
  final otpTEController = TextEditingController();
  final focusNode = FocusNode();

  final secondsRemaining = 60.obs;
  final isResendClickable = false.obs;
  final isLoading = false.obs;

  String? fromScreen;
  String? email;

  Timer? _timer;
  final isButtonEnabled = false.obs; // ← Add this

  void updateOtpValue(String value) {
    isButtonEnabled.value =
        value.length == 6 && value.contains(RegExp(r'^\d+$'));
  }

  @override
  void onInit() {
    super.onInit();
    fromScreen = Get.arguments?['formScreen'];
    email = Get.arguments?['email'];
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    secondsRemaining.value = 60;
    isResendClickable.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendClickable.value = true;
        timer.cancel();
      }
    });
  }

  String get countdownText {
    final min = (secondsRemaining.value ~/ 60).toString();
    final sec = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  Future<void> verifyOtp({
    required String otp,
    required String email,
    required String verifyType,
  }) async {
    if (otp.length != 6 || !otp.contains(RegExp(r'^\d+$'))) {
      AppToasts.errorToast(message: 'Please enter valid 6-digit OTP');
      return;
    }

    isLoading.value = true;

    try {
      final body = {"email": email, "otp": int.parse(otp), "type": verifyType};

      final response = await NetworkCaller().postRequest(
        AppUrls.verifyOtp,
        body: body,
      );

      if (response.isSuccess) {
        if (verifyType == VerifyType.SIGNUP.name) {
          Future.delayed(const Duration(milliseconds: 800), () {
            showSignupConfirmationDialog(
              image: IconPath.success,
              title: 'Success',
              subTitle: 'Your account is successfully created.',
              butonText: 'Go Login',
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
            );
          });
        }
        else if (verifyType == VerifyType.FORGET.name) {
          final accessToken = response.responseData?['data'] as String?;
          if (accessToken != null) {
            Get.off(() => ResetPasswordScreen(token: accessToken));
          }
        }
      } else {
        String msg = response.errorMessage;
        if (response.statusCode == 408) msg = 'OTP expired. Please resend.';
        if (response.statusCode == 409) msg = 'Incorrect OTP';
        AppSnackBar.error(msg);
      }
    } catch (e) {
      AppLoggerHelper.error('OTP verify error: $e');
      AppSnackBar.error('Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  final RxBool isResentPasswordLoading = false.obs;
  Future<void> resendOtp({required String email}) async {
    isResentPasswordLoading.value = true;
    try {
      final response = await NetworkCaller().postRequest(
        AppUrls.resendOtp,
        body: {"email": email},
      );
      if (response.isSuccess) {
        _startCountdown();
        AppSnackBar.success('OTP resent successfully');
      } else {
        String msg = response.errorMessage;
        if (response.statusCode == 429) msg = 'Too many requests. Try later';
        AppSnackBar.error(msg);
      }
    } catch (e) {
      AppLoggerHelper.error('Resend OTP error: $e');
      AppSnackBar.error('Something went wrong');
    } finally {
      isResentPasswordLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpTEController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
