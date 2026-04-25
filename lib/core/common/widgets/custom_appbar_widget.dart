import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

import 'custom_back_button.dart';
import 'custom_text.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final String? subtitle;
  final bool showBackButton;
  final bool? heightExtendTrue;
  final VoidCallback? onSearchTab;
  final VoidCallback? onCalenderTap;
  final VoidCallback? onBackTab;
  final VoidCallback? onCreateLearn;
  final VoidCallback? onCreateOpenChat;
  final Widget? subtitleWidget;

  const CustomAppbarWidget({
    super.key,
    required this.text,
    this.onSearchTab,
    this.onBackTab,
    this.showBackButton = true,
    this.onCalenderTap,
    this.onCreateLearn,
    this.onCreateOpenChat,
    this.heightExtendTrue,
    this.subtitle,
    this.subtitleWidget,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(heightExtendTrue == true ? 80.h : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.black.withAlpha(30),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// 🔹 CENTER TITLE
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: CustomText(
                      text: text,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (subtitleWidget != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: subtitleWidget!,
                    ),
                  ] else if (subtitle != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: CustomText(
                        text: subtitle!,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),

              /// 🔹 LEFT SIDE
              Align(
                alignment: Alignment.centerLeft,
                child: showBackButton
                    ? CustomBackButton(
                        onTap: onBackTab,
                        color: AppColors.backgroundColor.withAlpha(120),
                      )
                    : const SizedBox(),
              ),

              /// 🔹 RIGHT SIDE
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onSearchTab != null)
                      _circleIcon(
                        icon: Icons.search,
                        bgColor: AppColors.primary,
                        iconColor: AppColors.white,
                        onTap: onSearchTab!,
                      ),

                    if (onCalenderTap != null)
                      _circleIcon(
                        icon: Icons.calendar_month,
                        bgColor: AppColors.containerSoft,
                        iconColor: AppColors.primary,
                        border: Border.all(color: AppColors.primary),
                        onTap: onCalenderTap!,
                      ),

                    if (onCreateLearn != null) _createButton(onCreateLearn!),

                    if (onCreateOpenChat != null)
                      _createButton(onCreateOpenChat!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    Border? border,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.h),
        child: Container(
          height: 48.h,
          width: 48.h,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, size: 24.sp, color: iconColor),
        ),
      ),
    );
  }

  Widget _createButton(VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Create",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              Gap(6.w),
              Container(
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, size: 16.sp, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
