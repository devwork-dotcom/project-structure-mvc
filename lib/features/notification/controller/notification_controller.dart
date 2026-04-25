import 'dart:developer';
import 'package:get/get.dart';
import 'package:project_structure/core/utils/constants/app_urls.dart';
import 'package:project_structure/features/notification/model/notification_single_model.dart';

import 'package:project_structure/core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../model/notifications_model.dart';

class NotificationController extends GetxController {
  var isNotificationLoading = false.obs;
  var isNotificationSingleLoading = false.obs;
  var notificationModel = Rxn<NotificationsModel>();
  var notificationSingleModel = Rxn<NotificationSingleModel>();

  /// 🔹 UNREAD NOTIFICATION COUNT
  int get unreadCount {
    final list = notificationModel.value?.data ?? [];
    return list.where((e) => e.read == false).length;
  }

  Future<void> fetchNotification() async {
    isNotificationLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      notificationModel.value = NotificationsModel(
        success: true,
        message: "Notifications fetched successfully",
        data: [
          Datum(
            id: "1",
            receiverId: "101",
            senderId: "201",
            title: "Workout Reminder 💪",
            body: "Don't forget your cardio session today!",
            commentId: null,
            replyCommentId: null,
            groupBuyId: null,
            learnId: "L1001",
            openChatId: null,
            announcementId: null,
            read: false,
            createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
            updatedAt: DateTime.now(),
          ),
          Datum(
            id: "2",
            receiverId: "101",
            senderId: "202",
            title: "New Nutrition Plan 🥗",
            body: "Your weekly meal plan is ready to view.",
            commentId: null,
            replyCommentId: null,
            groupBuyId: null,
            learnId: null,
            openChatId: "C3001",
            announcementId: null,
            read: true,
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
            updatedAt: DateTime.now(),
          ),
          Datum(
            id: "3",
            receiverId: "101",
            senderId: "Admin",
            title: "Announcement 📢",
            body: "New mindfulness session available now.",
            commentId: null,
            replyCommentId: null,
            groupBuyId: null,
            learnId: null,
            openChatId: null,
            announcementId: "A5001",
            read: false,
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            updatedAt: DateTime.now(),
          ),
        ],
      );
    } catch (e) {
      log("Error fetching notification data: $e");
    } finally {
      isNotificationLoading(false);
    }
  }

  Future<bool> fetchNotificationSingle(String notificationId) async {
    isNotificationSingleLoading(true);
    try {
      final response = await NetworkCaller().getRequest(
        "${AppUrls.forgetPassword}/$notificationId",
        token: "Bearer ${AuthService.token}",
      );

      log("🔔 Notification hit response: ${response.responseData}");

      if (response.isSuccess) {
        notificationSingleModel.value = NotificationSingleModel.fromJson(
          response.responseData,
        );
        return true;
      }

      return false;
    } catch (e) {
      log("❌ Notification hit failed: $e");
      return false;
    } finally {
      isNotificationSingleLoading(false);
    }
  }

  Future<void> navigateFromNotification(Datum item) async {
    bool notificationHit = false;

    if (item.id != null && item.id!.isNotEmpty) {
      notificationHit = await fetchNotificationSingle(item.id!);
    }

    log("✅ Notification hit success: $notificationHit");

    /// Only navigate after hit attempt (success/fail both allowed)
    // if (item.announcementId?.isNotEmpty == true) {
    //   Get.to(() => AnnouncementDetailsScreen(
    //     id: item.announcementId!,
    //   ));
    //   fetchNotification();
    //   return;
    // }
    //
    // if (item.groupBuyId?.isNotEmpty == true) {
    //   Get.to(() => GroupBuyChatScreen(
    //     resourceId: item.groupBuyId!,
    //     resourceType: commentResourceType.groupBuy.name,
    //   ));
    //   fetchNotification();
    //   return;
    // }
    //
    //
    // if (item.openChatId?.isNotEmpty == true) {
    //   Get.to(() => OpenChatDetailsScreen(
    //     resourceId: item.openChatId!,
    //     commentResourceType: commentResourceType.openChat.name,
    //   ));
    //   fetchNotification();
    //   return;
    // }
    //
    // if (item.learnId?.isNotEmpty == true) {
    //   Get.to(() => LearnDetailsScreen(
    //     resourceId: item.learnId!,
    //     resourceType: commentResourceType.learn.name,
    //   ));
    //   fetchNotification();
    //   return;
    // }

    //AppSnackBar.error("No destination found for this notification");
  }

  void clearFiled() {
    Get.back();
    fetchNotification();
  }
}
