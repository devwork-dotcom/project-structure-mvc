import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/profile/controller/contact_and_support_controller.dart';

class AttachScreenshotCard extends StatelessWidget {
  const AttachScreenshotCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactAndSupportController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Attach Screenshot (Optional)",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),

        SizedBox(height: 10.h),

        Obx(
          () => GestureDetector(
            onTap: controller.selectedImage.value == null
                ? controller.pickImage
                : null, // image থাকলে tap disabled
            child: CustomContainer(
              color: AppColors.white,
              child: Container(
                height: 120.h,
                alignment: Alignment.center,
                child: controller.selectedImage.value == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_outlined,
                            size: 28.sp,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: "Tap to upload screenshot",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: "PNG or JPG, max 5MB",
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          /// Image Preview
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.h),
                            child: Image.file(
                              controller.selectedImage.value!,
                              width: double.infinity,
                              height: 120.h,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () {
                                controller.selectedImage.value = null;
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.h),
                                decoration: BoxDecoration(
                                  color: AppColors.black.withAlpha(150),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
