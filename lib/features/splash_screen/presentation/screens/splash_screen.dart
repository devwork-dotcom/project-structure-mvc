import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/icon_path.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          IconPath.logo,
                          width: 227.w,
                          height: 152.h,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      // Text
                      CustomText(
                        text: "Mind, Body & Spirit",
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: AppColors.textPrimary,
                      ),
                      Gap(8.h),
                      CustomText(
                        text: "Align Your Wellness Journey",
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            Container(
              width: 130.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.white.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
