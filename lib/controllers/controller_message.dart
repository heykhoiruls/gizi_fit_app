// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ControllerMessage {
  final messaging = FirebaseMessaging.instance;
  final flutterLocalNotification = FlutterLocalNotificationsPlugin();

  Future<void> notification(BuildContext context) async {
    await messaging.requestPermission();
    final token = await messaging.getToken();

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(
        {'token': token},
      );

      var androidInitilize =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettings =
          InitializationSettings(android: androidInitilize);
      flutterLocalNotification.initialize(initializationSettings,
          onSelectNotification: (String? payload) {
        try {
          if (payload != null && payload.isNotEmpty) {
          } else {}
        } catch (e) {}
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        BigTextStyleInformation bigText = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidNotification =
            AndroidNotificationDetails(
          'mawar_care',
          'mawar_care',
          importance: Importance.high,
          styleInformation: bigText,
          priority: Priority.high,
          playSound: true,
        );

        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotification);

        await flutterLocalNotification.show(
          0,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: message.data['body'],
        );
      });
    }
  }
}
