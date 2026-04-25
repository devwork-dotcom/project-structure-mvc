import 'package:flutter/material.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.h),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 10.h),
          ),
          BoxShadow(
            color: AppColors.black.withAlpha(2),
            blurRadius: 6,
            offset: Offset(0, 2.h),
          ),
        ],

        /// 🔥 subtle border (important for white bg)
        border: Border.all(color: AppColors.textSecondary.withAlpha(8)),
      ),
      child: child,
    );
  }
}
