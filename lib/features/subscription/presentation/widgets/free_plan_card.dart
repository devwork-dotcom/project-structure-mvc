import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class FreePlanCard extends StatelessWidget {
  const FreePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Plan Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.containerSoft,
              borderRadius: BorderRadius.circular(30),
            ),
            child: CustomText(
              text: "Free Plan",
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 16.h),

          /// 🔹 Title
          CustomText(
            text: "Align Foundation",
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.primary,
          ),

          SizedBox(height: 8.h),
          CustomText(
            text:
                "Essential tools for building healthy habits for life-changing impact.",
            fontSize: 14.sp,
            color: AppColors.primary,
          ),
          SizedBox(height: 18.h),

          /// 🔹 Feature List
          _buildFeature("Daily Bible verses"),
          _buildFeature("Basic meal tracking"),
          _buildFeature("Hydration tracking"),
          _buildFeature("Workout logging"),
        ],
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.check, color: AppColors.success, size: 20.sp),
          SizedBox(width: 8.h),
          Expanded(
            child: CustomText(
              text: text,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
