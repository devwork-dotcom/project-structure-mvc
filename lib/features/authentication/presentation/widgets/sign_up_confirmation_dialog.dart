import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/utils/constants/app_colors.dart';

void showSignupConfirmationDialog({
  required String image,
  required String title,
  required String subTitle,
  required String butonText,
  required VoidCallback onTap,
}) {
  Get.dialog(
    AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UniversalImage(
              imagePath: image,
              height: 100.h,
              width: 132.w,
              fit: BoxFit.cover,
            ),
            Gap(24.h),
            CustomText(
              textAlign: TextAlign.center,
              text: title,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontSize: 18.sp,
            ),
            CustomText(
              textAlign: TextAlign.center,
              text: subTitle,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              fontSize: 14.sp,
            ),
            Gap(32.h),
            CustomButton(
              text: butonText,
              onTap: () {
                onTap();
              },
            ),
          ],
        ),
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.white,
    ),
  );
}
