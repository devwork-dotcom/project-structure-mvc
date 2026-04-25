import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/loader.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cancelText;
  final VoidCallback? onCancel;
  final String submitText;
  final VoidCallback onSubmit;
  final RxBool? isLoading;

  const ConfirmationDialog({
    super.key,
    this.title = "Are you sure?",
    this.subtitle = "Please confirm to continue this action.",
    this.cancelText = "Cancel",
    this.onCancel,
    required this.submitText,
    required this.onSubmit,
    this.isLoading,
  });

  static Future<void> show({
    String title = "Are you sure?",
    String subtitle = "Please confirm to continue this action.",
    String cancelText = "Cancel",
    VoidCallback? onCancel,
    required String submitText,
    required VoidCallback onSubmit,
    RxBool? isLoading,
    bool barrierDismissible = true,
  }) async {
    await Get.dialog(
      ConfirmationDialog(
        title: title,
        subtitle: subtitle,
        cancelText: cancelText,
        onCancel: onCancel,
        submitText: submitText,
        onSubmit: onSubmit,
        isLoading: isLoading,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.h)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 56.h,
                width: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 28.sp,
                ),
              ),
              Gap(16.h),
              CustomText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              Gap(8.h),
              CustomText(
                text: subtitle,
                textAlign: TextAlign.center,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                maxLines: 3,
              ),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: cancelText,
                      backgroundColor: AppColors.white,
                      isOutline: true,
                      borderColor: AppColors.containerBorder,
                      onTap: onCancel ?? () => Get.back(),
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: isLoading != null
                        ? Obx(() {
                            final loading = isLoading!.value;
                            return loading
                                ? const Loader()
                                : CustomButton(
                                    text: submitText,
                                    backgroundColor: AppColors.error.withAlpha(
                                      40,
                                    ),
                                    textColor: AppColors.error,
                                    onTap: onSubmit,
                                  );
                          })
                        : CustomButton(
                            text: submitText,
                            backgroundColor: AppColors.error.withAlpha(40),
                            textColor: AppColors.error,
                            onTap: onSubmit,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
