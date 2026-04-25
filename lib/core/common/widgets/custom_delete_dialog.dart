import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class CustomDeleteDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final RxBool? isLoading;

  const CustomDeleteDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onConfirm,
    this.onCancel,
    this.confirmText = "Delete",
    this.cancelText = "Cancel",
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: AppColors.white.withAlpha(0),
      child: CustomContainer(
        color: AppColors.white,
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Title
            CustomText(
              text: title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              textAlign: TextAlign.center,
            ),

            Gap(12.h),

            /// 🔹 Subtitle
            CustomText(
              text: subTitle,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),

            Gap(24.h),

            /// 🔹 Buttons
            Row(
              children: [
                /// 🔸 Cancel Button
                Expanded(
                  child: CustomButton(
                    text: cancelText,
                    onTap: onCancel ?? () => Get.back(),
                    backgroundColor: AppColors.white,
                    textColor: AppColors.textSecondary,
                    borderColor: AppColors.containerBorder,
                    isOutline: true,
                    height: 44.h,
                  ),
                ),

                Gap(16.w),

                /// 🔸 Confirm (Delete) Button
                Expanded(
                  child: Obx(
                    () => isLoading?.value == true
                        ? const Loader()
                        : CustomButton(
                            text: confirmText,
                            onTap: onConfirm,
                            backgroundColor: AppColors.error,
                            textColor: AppColors.white,
                            height: 44.h,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
