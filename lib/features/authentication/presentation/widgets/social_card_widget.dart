import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import 'package:project_structure/features/authentication/controllers/social_auth_login.dart';
import 'package:project_structure/core/common/widgets/loader.dart';

class SocialCardWidget extends StatelessWidget {
  const SocialCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SocialAuthController());
    return Obx(() {
      if (controller.isSocialLoading.value || controller.isAppleLoading.value) {
        return const Loader();
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: controller.googleLogin,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: UniversalImage(
                  imagePath: IconPath.google,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          if (Platform.isIOS) ...[
            Gap(24.w),
            InkWell(
              onTap: controller.appleLogin,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  child: UniversalImage(
                    imagePath: IconPath.apple,
                    height: 24.h,
                    width: 24.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    });
  }
}
