import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/common/widgets/custom_container.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/notification/presentation/screen/notification_screen.dart';
import 'package:project_structure/features/profile/controller/profile_controller.dart';

class NotificationReminderCard extends StatelessWidget {
  const NotificationReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return InkWell(
      onTap: () {
        Get.to(() => NotificationScreens());
      },
      child: CustomContainer(
        color: AppColors.white,
        margin: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// LEFT TEXT
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 28.sp,
                    color: AppColors.primary,
                  ),
                  Gap(6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Notifications",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 6.h),
                        CustomText(
                          text: "Reminders and updates",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// RIGHT SWITCH
            Obx(
              () => SizedBox(
                width: 48.w,
                height: 32.h,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    value: controller.isPushNotificationReminderOn.value,
                    onChanged: controller.toggleNotificationReminder,

                    /// ON State
                    activeThumbColor: AppColors.white,
                    activeTrackColor: AppColors.primary,

                    /// OFF State
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.textSecondary,

                    /// Remove default grey outline
                    trackOutlineColor: WidgetStateProperty.all(
                      AppColors.white.withAlpha(0),
                    ),
                    trackOutlineWidth: WidgetStateProperty.all(0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
