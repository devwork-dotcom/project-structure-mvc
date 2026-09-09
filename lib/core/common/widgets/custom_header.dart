import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

class HomeDashboardHeader extends StatelessWidget {
  const HomeDashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.unreadMessageCount,
    required this.unreadNotificationCount,
    required this.onTapMessage,
    required this.onTapNotification,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final int unreadMessageCount;
  final int unreadNotificationCount;
  final VoidCallback onTapMessage;
  final VoidCallback onTapNotification;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.h),
          bottomRight: Radius.circular(24.h),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.verseGradient),
          child: Stack(
            children: [
              Positioned(
                right: -46.w,
                top: -40.h,
                child: _HeaderBubble(
                  size: 150.h,
                  color: AppColors.white.withAlpha(12),
                ),
              ),
              Positioned(
                right: 72.w,
                bottom: 18.h,
                child: Transform.rotate(
                  angle: -.52,
                  child: Container(
                    height: 76.h,
                    width: 166.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withAlpha(34),
                      borderRadius: BorderRadius.circular(90.h),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  18.w,
                  MediaQuery.viewPaddingOf(context).top + 14.h,
                  18.w,
                  22.h,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.white.withAlpha(34),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white.withAlpha(28),
                        ),
                      ),
                      child: Icon(icon, color: AppColors.white, size: 25.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: title,
                            color: AppColors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: subtitle,
                            color: AppColors.white.withAlpha(198),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    _HeaderActionButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      count: unreadMessageCount,
                      onTap: onTapMessage,
                    ),
                    SizedBox(width: 8.w),
                    _HeaderActionButton(
                      icon: Icons.notifications_none_rounded,
                      count: unreadNotificationCount,
                      onTap: onTapNotification,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(34.h),
          child: Container(
            height: 36.h,
            width: 36.h,
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(36),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withAlpha(30)),
            ),
            child: Icon(icon, color: AppColors.white, size: 19.sp),
          ),
        ),
        if (count > 0)
          Positioned(
            right: -2.w,
            top: -3.h,
            child: Container(
              constraints: BoxConstraints(minHeight: 16.h, minWidth: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HeaderBubble extends StatelessWidget {
  const _HeaderBubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}