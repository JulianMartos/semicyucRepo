import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'semicyucnotifications',
      'Semicyuc Notifications Channel',
      description: 'Semicyuc Notifications Channel For Firebase',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void display(RemoteMessage msg) async {
    try {
      // final smallIcn = msg.notification?.android?.smallIcon;
      const NotificationDetails notDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'semicyucnotifications',
          'Semicyuc Notifications Channel',
          channelDescription: 'Semicyuc Notifications Channel For Firebase',
          importance: Importance.max,
          priority: Priority.high,
          // icon: smallIcn,
        ),
      );
      await _flutterLocalNotificationsPlugin.show(
        msg.hashCode,
        msg.notification!.title,
        msg.notification!.body,
        notDetails,
      );
    } on Exception catch (e) {
      print(e);
      // TODO
    }
  }
}
