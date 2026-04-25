import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/constants/app_colors.dart';

import '../common/widgets/custom_button.dart';
import 'language_controller.dart';

Widget buildLanguageTile(String language, String value) {
  final controller = Get.find<LanguageController>();
  return Obx(
    () => CustomButton(
      text: language,
      onTap: () {
        controller.saveLanguage(value);
      },
      isOutline: true,
      backgroundColor: controller.selectedLanguage.value == value
          ? AppColors.primary
          : AppColors.white.withAlpha(0),
      borderColor: controller.selectedLanguage.value == value
          ? AppColors.primary
          : AppColors.borderColor,
      textColor: controller.selectedLanguage.value == value
          ? AppColors.white
          : AppColors.textPrimary,
    ),
  );
}
