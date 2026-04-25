import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/constants/app_sizer.dart';

import '../../utils/constants/app_colors.dart';

class AppToasts {
  static Future<void> successToast({
    required String message,
    ToastGravity toastGravity = ToastGravity.CENTER,
  }) async {
    await _cancelExistingToasts();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.success,
      textColor: AppColors.white,
      fontSize: 14.sp,
      webBgColor: AppColors.toWebHex(AppColors.success),
      webPosition: "center",
      webShowClose: true,
    );
  }

  static Future<void> errorToast({
    required String message,
    ToastGravity toastGravity = ToastGravity.CENTER,
  }) async {
    await _cancelExistingToasts();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.error,
      textColor: AppColors.white,
      fontSize: 14.sp,
      webBgColor: AppColors.toWebHex(AppColors.error),
      webPosition: "center",
      webShowClose: true,
    );
  }

  static Future<void> warningToast({
    required String message,
    ToastGravity toastGravity = ToastGravity.CENTER,
  }) async {
    await _cancelExistingToasts();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.warning, // Amber/Warning color
      textColor: AppColors.white,
      fontSize: 14.sp,
      webBgColor: AppColors.toWebHex(AppColors.warning),
      webPosition: "center",
      webShowClose: true,
    );
  }

  static Future<void> infoToast({
    required String message,
    ToastGravity toastGravity = ToastGravity.CENTER,
  }) async {
    await _cancelExistingToasts();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.info, // Blue/Info color
      textColor: AppColors.white,
      fontSize: 14.sp,
      webBgColor: AppColors.toWebHex(AppColors.info),
      webPosition: "center",
      webShowClose: true,
    );
  }

  static Future<void> _cancelExistingToasts() async {
    await Fluttertoast.cancel();
  }
}
