import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'package:project_structure/core/services/auth_service.dart';
import 'core/services/notification_services.dart';

import 'core/utils/logging/loggerformain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  try {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint("Firebase Messaging background handler setup failed: $e");
  }
  await AuthService.init();
  try {
    final notificationService = PushNotificationService();
    await notificationService.initialize();
    await notificationService.setupIOSNotifications();
  } catch (e) {
    debugPrint("PushNotificationService initialization failed: $e");
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  runApp(const MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase for background message handling
  try {
    await Firebase.initializeApp();
    log("Handling a background message: ${message.messageId}");
  } catch (e) {
    log("Firebase Background Init Failed: $e");
  }
}
