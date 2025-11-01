import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/strings.dart';
import 'features/Home/business logic/cubit/cubit/my_orders_cubit.dart';
import 'main.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    fcmToken = await messaging.getToken();
    log("FCM Token: $fcmToken");
    FirebaseMessaging.onBackgroundMessage(handlerMessaging);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _refreshOrders();
    });
  }

  static Future<void> handlerMessaging(RemoteMessage message) async {
    log("🔔 Background message: ${message.notification?.title}");
    _refreshOrders();
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    log("📩 Foreground message: ${message.notification?.title}");
    _refreshOrders();
  }

  static void _refreshOrders() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      try {
        context.read<GetMyOrdersCubit>().getAllOrders();
        log("✅ Orders refreshed after notification");
      } catch (e) {
        log("⚠️ Failed to refresh orders: $e");
      }
    } else {
      log("⚠️ No context available to refresh orders");
    }
  }
}
