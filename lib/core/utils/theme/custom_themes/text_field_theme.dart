import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static InputDecorationTheme _baseInputDecorationTheme({
    required Color labelColor,
    required Color hintColor,
    required Color errorColor,
    required Color focusedErrorColor,
    required Color prefixIconColor,
    required Color suffixIconColor,
    required Color borderColor,
    required Color enabledBorderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
    required Color focusedErrorBorderColor,
  }) {
    return InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: prefixIconColor,
      suffixIconColor: suffixIconColor,
      labelStyle: TextStyle(fontSize: 14, color: labelColor),
      hintStyle: TextStyle(fontSize: 14, color: hintColor),
      errorStyle: TextStyle(fontSize: 12, color: errorColor),
      floatingLabelStyle: TextStyle(color: labelColor.withValues(alpha: 0.8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: errorBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: focusedErrorBorderColor),
      ),
    );
  }

  static final InputDecorationTheme lightInputDecorationTheme =
      _baseInputDecorationTheme(
        labelColor: AppColors.black,
        hintColor: AppColors.black,
        errorColor: AppColors.error,
        focusedErrorColor: AppColors.warning,
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        borderColor: AppColors.textSecondary,
        enabledBorderColor: AppColors.textSecondary,
        focusedBorderColor: AppColors.black,
        errorBorderColor: AppColors.error,
        focusedErrorBorderColor: AppColors.warning,
      );

  static final InputDecorationTheme darkInputDecorationTheme =
      _baseInputDecorationTheme(
        labelColor: AppColors.white,
        hintColor: AppColors.containerSoft,
        errorColor: AppColors.error,
        focusedErrorColor: AppColors.warning,
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        borderColor: AppColors.textSecondary,
        enabledBorderColor: AppColors.textSecondary,
        focusedBorderColor: AppColors.white,
        errorBorderColor: AppColors.error,
        focusedErrorBorderColor: AppColors.warning,
      );
}
