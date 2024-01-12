import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> scheduleNotification(String title, String body, DateTime scheduledTime) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Create notification details
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.high,
    priority: Priority.high,
  );

  // final IOSNotificationDetails iOSPlatformChannelSpecifics =
  // IOSNotificationDetails();

  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    //iOS: iOSPlatformChannelSpecifics,
  );

  // Convert scheduled time to timezone
  final tz.TZDateTime scheduledDate =
  tz.TZDateTime.from(scheduledTime, tz.local);

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    scheduledDate,
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}
