import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class SubscriptionCard extends StatelessWidget {
  final VoidCallback onTap;

  const SubscriptionCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          CustomText(
            text: "Subscription",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),

          SizedBox(height: 16.h),

          /// Plan Name
          CustomText(
            text: "Align Foundation",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),

          SizedBox(height: 4.h),

          /// Subtitle
          CustomText(
            text:
                "Essential tools to build healthy habits for life-changing impact.",
            fontSize: 14.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),

          SizedBox(height: 20.h),

          /// Upgrade Button
          CustomButton(
            onTap: onTap,
            text: "Upgrade to Align Complete",
            backgroundColor: AppColors.warning,
            borderColor: AppColors.warning,
            padding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ],
      ),
    );
  }
}
