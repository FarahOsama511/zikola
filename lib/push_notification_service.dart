import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handlerMessaging);
    log(token ?? "");
  }

  static Future<void> handlerMessaging(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? "");
  }
}
