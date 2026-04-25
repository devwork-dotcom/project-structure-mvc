import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppBarThemeData {
  AppBarThemeData._();

  static AppBarTheme _baseAppBarTheme({
    required Color backgroundColor,
    required Color iconColor,
    required Color titleColor,
    required Color surfaceTintColor,
    required double elevation,
  }) {
    return AppBarTheme(
      foregroundColor: AppColors.white.withAlpha(0),
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      titleTextStyle: TextStyle(
        color: titleColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: iconColor),
      centerTitle: true,
      // systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static final AppBarTheme lightAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.white,
    iconColor: AppColors.black,
    titleColor: AppColors.black,
    surfaceTintColor: AppColors.primary,
    elevation: 3,
  );

  static final AppBarTheme darkAppBarTheme = _baseAppBarTheme(
    backgroundColor: AppColors.black,
    iconColor: AppColors.white,
    titleColor: AppColors.white,
    surfaceTintColor: AppColors.white.withAlpha(0),
    elevation: 0,
  );
}
