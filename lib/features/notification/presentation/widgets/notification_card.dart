import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String? image;
  final String title;
  final String description;
  final String timeAgo;
  final bool read;
  final VoidCallback onTab;

  const NotificationCard({
    super.key,
    this.image,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.read,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withAlpha(30),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP Row (Image + Title + Time)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Image + Title
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 20.sp,
                        color: AppColors.warning,
                      ),

                      SizedBox(width: 8.w),

                      Expanded(
                        child: CustomText(
                          text: title,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Time Ago
                CustomText(
                  text: timeAgo,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ],
            ),

            SizedBox(height: 8.h),

            /// Description
            CustomText(
              text: description,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),

            if (!read)
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.visibility,
                  color: AppColors.error,
                  size: 14.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
