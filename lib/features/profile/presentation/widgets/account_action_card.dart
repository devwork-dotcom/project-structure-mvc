import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_button.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class AccountActionsCard extends StatelessWidget {
  final VoidCallback onLogoutTap;
  final VoidCallback onDeleteTap;

  const AccountActionsCard({
    super.key,
    required this.onLogoutTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          CustomText(
            text: "Account Actions",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),

          SizedBox(height: 20.h),

          /// 🔹 Logout Button
          CustomButton(
            text: "Logout",
            onTap: onLogoutTap,
            height: 44.h,
            borderRadius: BorderRadius.circular(12.h),
            backgroundColor: AppColors.backgroundColor,
            textColor: AppColors.primary,
            prefixIcon: Icon(
              Icons.logout,
              size: 20.sp,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 14.h),

          /// 🔹 Delete Account Button
          CustomButton(
            text: "Delete Account",
            onTap: onDeleteTap,
            height: 44.h,
            borderRadius: BorderRadius.circular(12.h),
            backgroundColor: AppColors.error.withAlpha(30),
            textColor: AppColors.error,
            prefixIcon: Icon(
              Icons.delete_forever_sharp,
              size: 20.sp,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
