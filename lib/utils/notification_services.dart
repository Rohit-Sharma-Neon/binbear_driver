import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void display(int id,String title,String body,filePath) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            "BinBearDriver",
            "binbeardriverchannel",
            icon: '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true,presentSound: true)
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: filePath,
      );
      const InitializationSettings initializationSettings = InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings()
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}