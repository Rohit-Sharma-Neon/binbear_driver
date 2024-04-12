import 'dart:developer';
import 'package:binbeardriver/firebase_options.dart';
import 'package:binbeardriver/utils/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotificationService {

  Future<void>initFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessaging.instance.subscribeToTopic("bin_bear_driver_service");
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    debugPrint("FCM Token -> ${token??""} <-");
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    // firebaseMessaging.requestPermission(
    //   alert: false,
    //   announcement: false,
    //   provisional: false,
    //   sound: false,
    //   badge: false,
    //   criticalAlert: false,
    // );
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Title: \n${message.notification?.title??""}');
      log('Body: \n${message.notification?.title??""}');
      log('Data: \n${message.data}');
      NotificationServices.display(1, message.notification?.title??"", message.notification?.body??"", "");
    });
    /// Terminate/Background (This function will only trigger on notification tap)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.notification?.title??"");
    });
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title: \n${message.notification?.title??""}');
  log('Body: \n${message.notification?.title??""}');
  log('Data: \n${message.data}');
  NotificationServices.display(1, message.notification?.title??"", message.notification?.body??"", "");
}