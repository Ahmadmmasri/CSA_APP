import 'dart:convert';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/csa_app.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final FirebaseMessaging _fireMessaging = FirebaseMessaging.instance;
  final CsaAuthCubit notificationCubit = CsaAuthCubit();

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  final localNotifiction = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _fireMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
    );
    //final fcToken = await _fireMessaging.getToken();
    // debugPrint('fcm token $fcToken');
    initPushNotification();
    initLocalNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.notificationDetailsScreen,
      (route) => true,
      arguments: message.notification,
    );
  }

  Future initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: android, iOS: ios);

    await localNotifiction.initialize(setting,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });

    final platform = localNotifiction.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Future<void> _backgroundHandler(RemoteMessage message) async {}
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

      final notification = message.notification;

      if (notification == null) return;

      localNotifiction.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );

      notificationCubit.incrementNotification();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message);
    });
  }
}
