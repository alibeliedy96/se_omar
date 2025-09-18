import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static initializeLocalNotification(
      {void Function(Map<String, dynamic> data)? onNotificationPressed,
        required String icon}) async {
    // Create an Android Notification Channel.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings(icon);
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();  // تم إزالة المعلمة here
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse : (payload) {
        onSelectNotification(payload: payload.payload, onData: onNotificationPressed);
      },
    );
  }

  static Future onSelectNotification({String? payload, onData}) async {
    if (payload != null) {
      print('notification payload payload $payload');
      var jsonData = jsonDecode(payload);
      onData(jsonData);
      print('jsonData $jsonData');
    }
  }

  static showNotification(
      {required RemoteNotification notification,
        Map<String, dynamic>? payload,
        String? icon}) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            priority: Priority.max, playSound: true,
            importance: Importance.max,
            sound: const RawResourceAndroidNotificationSound('notification'),
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
            presentBadge:true,   // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
            presentSound: true,   // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
          ),
        ),
        payload: jsonEncode(payload));
  }
}
