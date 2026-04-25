import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/common/widgets/customContainer_button.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class MyAchievementsCard extends StatelessWidget {
  final VoidCallback onTap;
  final int fitnessMinValue;
  final int fitnessMaxValue;

  const MyAchievementsCard({
    super.key,
    required this.onTap,
    required this.fitnessMinValue,
    required this.fitnessMaxValue,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = fitnessMaxValue == 0
        ? 0
        : (fitnessMinValue / fitnessMaxValue).clamp(0, 1);

    final int remaining = fitnessMaxValue - fitnessMinValue;

    return CustomContainer(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          CustomText(
            text: "My Achievements",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),

          SizedBox(height: 18.h),

          /// Row (Icon + Title + Value)
          Row(
            children: [
              /// Trophy Circle
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.secondary, AppColors.primary],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.h),
                  child: Icon(
                    Icons.emoji_events,
                    color: AppColors.white,
                    size: 36.sp,
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              /// Title & Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Fitness Champion",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        CustomText(
                          text: "$fitnessMinValue/$fitnessMaxValue",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    /// Progress Bar
                    Stack(
                      children: [
                        Container(
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppColors.containerBorder,
                            borderRadius: BorderRadius.circular(6.h),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: progress,
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.info, AppColors.primary],
                              ),
                              borderRadius: BorderRadius.circular(6.h),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    CustomText(
                      text: remaining > 0
                          ? "$remaining more to unlock"
                          : "Unlocked 🎉",
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          /// Button
          SizedBox(
            width: double.infinity,
            child: CustomContainerButton(
              onTap: onTap,
              text: "Upgrade to Premium",
              backgroundColor: AppColors.warning,
              borderColor: AppColors.warning,
              borderRadius: 12.h,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
