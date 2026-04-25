import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class PremiumPlanCard extends StatelessWidget {
  final VoidCallback onTapPremium;
  const PremiumPlanCard({super.key, required this.onTapPremium});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomContainer(
          margin: EdgeInsets.only(top: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CustomText(
                text: "Align Complete",
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),

              SizedBox(height: 12.h),
              CustomText(
                text:
                    "Guided wellness training and premium equipment for transformative alignment.",
                color: AppColors.black,
              ),
              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: "\$12.99",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                  SizedBox(width: 4.h),
                  CustomText(
                    text: "/month",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// 🔹 Benefits Box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: CustomContainer(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),
                      _buildFeature("Everything in Foundation"),
                      _buildFeature("500+ meal recipes"),
                      _buildFeature("100+ workout plans"),
                      _buildFeature("Progress tracking"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// 🔹 Gradient Button
              InkWell(
                onTap: onTapPremium,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: AppColors.mindsetAlignGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "Unlock Premium",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              CustomText(
                text: "Cancel anytime. No commitment required.",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),

        Positioned(
          top: 8.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: AppColors.mindsetAlignGradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.h),
                    child: Icon(
                      Icons.auto_awesome,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
                  ),
                  CustomText(
                    text: "Recommended",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: AppColors.success, size: 18.sp),
          SizedBox(width: 8.h),
          Expanded(
            child: CustomText(
              text: text,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
