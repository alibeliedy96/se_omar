import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../cache/cache_helper.dart';
import 'local_notification.dart';

class FCM {
  static late ValueChanged<String?> _onTokenChanged;

  static initializeFCM(
      {required void Function(String? token) onTokenChanged,
      required Function(Map<String, dynamic> data)? onNotificationPressed,
      required BackgroundMessageHandler onNotificationReceived,
      GlobalKey<NavigatorState>? navigatorKey,
      required String icon}) async {
    _onTokenChanged = onTokenChanged;

    await LocalNotification.initializeLocalNotification(onNotificationPressed: onNotificationPressed, icon: icon);
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then(onTokenChanged);
    Stream<String> tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(onTokenChanged);

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(onNotificationReceived);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print('getInitialMessage');
      print(message?.data);
      if (message != null) {
        onNotificationReceived(message);
        onNotificationPressed!(message.data);
      }
    });

    /// when app open
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;


      if (notification != null) {


            LocalNotification.showNotification(
                notification: notification, payload: message.data, icon: icon);

        }


      // if (notification != null) {
      //   LocalNotification.showNotification(notification: notification, payload: message.data, icon: icon);
      // }


    });

    /// when app in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        LocalNotification.showNotification(notification: notification, payload: message.data, icon: icon);
      }
      onNotificationReceived(message);
      onNotificationPressed!(message.data);
    });


    /// when app in terminated
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print('A new onBackgroundMessage event was published!');

      onNotificationReceived(message);
      onNotificationPressed!(message.data);
    });
  }

  //static Future<void> _firebaseMessagingBackgroundHandler
  static deleteRefreshToken() {
    FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.instance.getToken().then(_onTokenChanged);
  }





}
