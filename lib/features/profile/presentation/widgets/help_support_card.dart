import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class HelpSupportCard extends StatelessWidget {
  final VoidCallback onTap;

  const HelpSupportCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        color: AppColors.white,
        child: Column(
          children: [
            /// 🔹 Icon Circle
            Container(
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.waving_hand_outlined,
                color: AppColors.warning,
                size: 28.sp,
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Title
            CustomText(
              text: "How can we help you?",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 6.h),

            /// 🔹 Subtitle
            CustomText(
              text: "We typically respond within 24 hours",
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
