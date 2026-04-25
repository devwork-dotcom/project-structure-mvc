import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class AppSnackBar {
  AppSnackBar._();

  static const Duration _defaultDuration = Duration(seconds: 3);
  static const double _defaultRadius = 16.0;

  static TextStyle get _titleStyle => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get _messageStyle => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white.withOpacity(0.9),
  );

  /// Success SnackBar
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.success, // Emerald
      icon: Icons.check_circle_rounded,
    );
  }

  /// Error SnackBar
  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.error, // Red
      icon: Icons.error_rounded,
    );
  }

  /// Warning SnackBar
  static void warning(String message, {String title = 'Warning'}) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.warning, // Amber
      icon: Icons.warning_rounded,
    );
  }

  /// Info SnackBar
  static void info(String message, {String title = 'Info'}) {
    _show(
      title: title,
      message: message,
      backgroundColor: AppColors.info, // Blue
      icon: Icons.info_rounded,
    );
  }

  /// Modern Toast implementation
  static void toast(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: _messageStyle.copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.black.withAlpha(200),
      borderRadius: 100,
      margin: EdgeInsets.symmetric(horizontal: 40.h, vertical: 20.w),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: Text(title, style: _titleStyle),
      messageText: Text(message, style: _messageStyle),
      icon: Icon(icon, color: AppColors.white, size: 28),
      backgroundColor: backgroundColor.withAlpha(240),
      colorText: AppColors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: _defaultRadius,
      duration: _defaultDuration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('DISMISS', style: TextStyle(color: AppColors.white)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}
