import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_structure/core/common/widgets/universal_Image.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: UniversalImage(imagePath: image, fit: BoxFit.contain),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              CustomText(
                textAlign: TextAlign.center,
                text: title,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              Gap(8.h),
              CustomText(
                textAlign: TextAlign.center,
                text: subtitle,
                color: AppColors.textSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Gap(24.h),
      ],
    );
  }
}
