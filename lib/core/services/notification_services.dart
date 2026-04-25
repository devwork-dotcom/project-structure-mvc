import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static String? fcmtoken;

  /// Initialize Push Notification Service
  Future<void> initialize() async {
    try {
      log("Starting push notification initialization");

      await _requestPermissions();

      /// Android Notification Channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Channel for high-priority notifications',
        importance: Importance.max,
      );

      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      await androidPlugin?.createNotificationChannel(channel);

      log("Android notification channel created");

      /// Initialization Settings
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      /// Initialize Local Notifications (NEW API)
      await _flutterLocalNotificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          log("Notification tapped with payload: ${response.payload}");
          _navigateToScreenFromLocal(response.payload);
        },
      );

      log("Local notifications initialized successfully");

      /// Get FCM Token
      fcmtoken = await _firebaseMessaging.getToken();
      log("FCM Token: $fcmtoken");

      /// Token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        fcmtoken = newToken;
        log("FCM Token refreshed: $newToken");
      });

      /// Foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("Foreground message received: ${message.toMap()}");
        _showLocalNotification(message);
      });

      /// Background (app opened from notification)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log("Background message clicked: ${message.toMap()}");
        _navigateToScreen(message);
      });

      /// Terminated state
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();

      if (initialMessage != null) {
        log("Terminated message received: ${initialMessage.toMap()}");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigateToScreen(initialMessage);
        });
      }

      await setupIOSNotifications();

      log("Push notification initialization completed");
    } catch (e, stackTrace) {
      log("Error initializing push notifications: $e", stackTrace: stackTrace);
    }
  }

  /// Request Permissions
  Future<void> _requestPermissions() async {
    try {
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(alert: true, badge: true, sound: true);

      log("iOS Authorization Status: ${settings.authorizationStatus}");

      if (Platform.isAndroid) {
        final status = await Permission.notification.request();
        log("Android Notification Permission: $status");
      }
    } catch (e, stackTrace) {
      log("Permission request error: $e", stackTrace: stackTrace);
    }
  }

  /// iOS Foreground Options
  Future<void> setupIOSNotifications() async {
    try {
      if (!kIsWeb && Platform.isIOS) {
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
        log("iOS foreground notification options set");
      }
    } catch (e, stackTrace) {
      log("iOS setup error: $e", stackTrace: stackTrace);
    }
  }

  /// Show Local Notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final String title =
          message.notification?.title ?? message.data['title'] ?? 'No Title';

      final String body =
          message.notification?.body ?? message.data['body'] ?? 'No Body';

      final String? payload = message.data['route'];

      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'Channel for high-priority notifications',
            importance: Importance.max,
            priority: Priority.high,
          );

      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      final int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      await _flutterLocalNotificationsPlugin.show(
        id: notificationId,
        title: title,
        body: body,
        notificationDetails: notificationDetails,
        payload: payload,
      );

      log("Local notification shown (ID: $notificationId)");
    } catch (e, stackTrace) {
      log("Error showing notification: $e", stackTrace: stackTrace);
    }
  }

  /// Navigate from FCM notification
  void _navigateToScreen(RemoteMessage message) {
    final String? route = message.data['route'];

    log("Navigation route from FCM: $route");

    if (route != null && navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(route);
    }
  }

  /// Navigate from Local notification
  void _navigateToScreenFromLocal(String? payload) {
    log("Navigation payload from local notification: $payload");

    if (payload != null && navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(payload);
    }
  }

  /// Test Notification
  Future<void> testLocalNotification() async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'Channel for high-priority notifications',
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
        id: 0,
        title: 'Test Notification',
        body: 'This is a test notification',
        notificationDetails: notificationDetails,
        payload: '/test',
      );

      log("Test notification sent");
    } catch (e, stackTrace) {
      log("Test notification error: $e", stackTrace: stackTrace);
    }
  }
}
