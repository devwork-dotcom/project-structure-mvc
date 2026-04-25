import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_text.dart';
import 'universal_Image.dart';

class CustomProfileAppbarCart extends StatelessWidget
    implements PreferredSizeWidget {
  final String image;
  final String name;
  final int notification;
  final VoidCallback onTabNotification;
  final VoidCallback onProfileTap;
  final bool isLoading;

  const CustomProfileAppbarCart({
    super.key,
    required this.image,
    required this.name,
    required this.notification,
    required this.onTabNotification,
    required this.onProfileTap,
    this.isLoading = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(90.h);

  @override
  Widget build(BuildContext context) {
    final status = _getGreeting();
    final dateText = _formattedDate();

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 20.h,
        right: 20.h,
        bottom: 8.h,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "$status,",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: AppColors.containerBorder,
                        highlightColor: AppColors.containerSoft,
                        child: Container(
                          height: 20.sp,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      )
                    : CustomText(
                        text: name,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                Gap(6.h),
                CustomText(
                  text: dateText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          Row(children: [_notificationIcon(), Gap(12.w), _profileImage()]),
        ],
      ),
    );
  }

  Widget _notificationIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTabNotification,
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColors.containerSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
        ),
        if (notification > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              height: 18.h,
              width: 18.h,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                notification > 99 ? "99+" : "$notification",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _profileImage() {
    return InkWell(
      onTap: onProfileTap,
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: AppColors.containerBorder,
              highlightColor: AppColors.containerSoft,
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
              ),
            )
          : UniversalImage(
              imagePath: image,
              height: 40.h,
              width: 40.h,
              isCircular: true,
              borderRadius: 100,
              fit: BoxFit.cover,
            ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    if (hour < 21) return "Good Evening";
    return "Good Night";
  }

  String _formattedDate() {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }
}
