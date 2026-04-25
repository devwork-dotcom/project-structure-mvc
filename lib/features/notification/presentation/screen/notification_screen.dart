import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_structure/core/common/widgets/custom_appbar_widget.dart';
import 'package:project_structure/core/common/widgets/custom_scaffold.dart';
import 'package:project_structure/core/common/widgets/custom_text.dart';
import 'package:project_structure/core/utils/constants/app_colors.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';
import 'package:project_structure/features/notification/controller/notification_controller.dart';
import 'package:project_structure/features/notification/presentation/widgets/notification_card.dart';

class NotificationScreens extends StatelessWidget {
  NotificationScreens({super.key});

  final controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchNotification();
    });

    return CustomScaffold(
      appBar: CustomAppbarWidget(text: "Notifications"),
      child: Column(
        children: [
          Gap(16.h),
          Obx(() {
            if (controller.isNotificationLoading.value) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 16,
                itemBuilder: (_, __) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.containerSoft,
                    highlightColor: AppColors.textPrimary,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: NotificationCard(
                        image: "",
                        title: "",
                        description: "",
                        read: false,
                        timeAgo: "",
                        onTab: () {},
                      ),
                    ),
                  );
                },
              );
            }

            final list = controller.notificationModel.value?.data ?? [];

            if (list.isEmpty) {
              return Center(child: Text("No notifications found"));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return NotificationCard(
                  image: "",
                  title: item.title ?? "",
                  description: item.body ?? "",
                  read: item.read ?? false,
                  timeAgo: _convertToAgo(item.createdAt),
                  onTab: () {
                    if (item.read == false) {
                      controller.navigateFromNotification(item);
                    }
                  },
                );
              },
            );
          }),

          Gap(20.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: CustomText(
                text:
                    "Tip: Enable push notifications in your device settings to stay on track with your health goals!",
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Convert DateTime to "2 min ago"
  String _convertToAgo(DateTime? date) {
    if (date == null) return "";

    final Duration diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hrs ago";
    return "${diff.inDays} days ago";
  }
}
