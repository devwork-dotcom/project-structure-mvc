import 'package:flutter/material.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class SupportLegalCard extends StatelessWidget {
  final VoidCallback onHelpTap;
  final VoidCallback onContactTap;
  final VoidCallback onPrivacyTap;
  final VoidCallback onTermsTap;

  const SupportLegalCard({
    super.key,
    required this.onHelpTap,
    required this.onContactTap,
    required this.onPrivacyTap,
    required this.onTermsTap,
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
            text: "Support & Legal",
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          SizedBox(height: 10.h),

          _item("Help & FAQ", onHelpTap),

          _divider(),

          _item("Contact Support", onContactTap),

          _divider(),

          _item("Privacy Policy", onPrivacyTap),

          _divider(),

          _item("Terms of Service", onTermsTap),
        ],
      ),
    );
  }

  Widget _item(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(color: AppColors.containerBorder, height: 1);
  }
}
