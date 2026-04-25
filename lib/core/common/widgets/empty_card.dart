import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class EmptyCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyCard({
    super.key,
    this.title = "No data available",
    this.subtitle = "Looks like there’s nothing here right now.",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(color: AppColors.containerBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Icon
          Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.eco_outlined,
              size: 30.sp,
              color: AppColors.textSecondary,
            ),
          ),

          Gap(20.h),

          /// Title
          CustomText(text: title, fontSize: 16.sp, fontWeight: FontWeight.w600),

          Gap(8.h),

          /// Subtitle
          CustomText(
            text: subtitle,
            fontSize: 13.sp,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
