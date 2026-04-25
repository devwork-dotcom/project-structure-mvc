import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/app_snackber.dart';
import 'package:project_structure/features/nav_bar/presentation/screens/nav_bar.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'package:project_structure/core/services/network_caller.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordText = TextEditingController();
  RxBool rememberMe = false.obs;

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  @override
  void onInit() {
    super.onInit();
    rememberMe.value = AuthService.rememberMe;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
    AuthService.saveRememberMe(rememberMe.value);
  }

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordText.text.trim();

    if (email.isEmpty) {
      AppSnackBar.error('Please enter your email.');
      return;
    }
    if (password.isEmpty) {
      AppSnackBar.error('Please enter your password.');
      return;
    }

    isLoading.value = true;

    try {
      final response = await NetworkCaller().postRequest(
        AppUrls.login,
        body: {"email": email, "password": password},
      );

      if (response.isSuccess && response.statusCode == 200) {
        final token = response.responseData['data']?['accessToken'] ?? '';
        final roles = response.responseData['data']['role'];
        final userID = response.responseData['data']['id'];

        log('Token: $token, UserID: $userID, Roles: $roles,');
        if (token != null && token.isNotEmpty) {
          await AuthService.saveToken(token);
          await AuthService.saveRole(roles);
          await AuthService.saveUID(userID);
          await AuthService.saveRememberMe(rememberMe.value);
          //Get.offAll(()=>InformationScreen());
          Get.offAll(() => NavBar());
          // AppSnackBar.success( 'Login successful!');
        } else {
          AppSnackBar.error('Access token not found');
        }
      } else {
        String message = response.errorMessage;

        switch (response.statusCode) {
          case 203:
            message = 'Invalid password';
            break;
          case 404:
            message = 'Account not found';
            break;
        }

        AppSnackBar.error(message);
      }
    } catch (e) {
      log('Login error: $e');
      AppSnackBar.error(
        e.toString().contains('Timeout')
            ? 'Request timed out'
            : 'Something went wrong',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
