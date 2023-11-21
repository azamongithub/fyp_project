import 'dart:math';
import 'package:CoachBot/view/bottom_nav_tabs/plans_tab.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payLoad) {
      handleMessage(context, message);
      const AndroidInitializationSettings('@mipmap/ic_launcher');
        });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus ==
        AuthorizationStatus.authorized) //For Android
    {
      if (kDebugMode) {
        print('User granted authorized permissions');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) //For Iphone
    {
      if (kDebugMode) {
        print('User granted provisional permissions');
      }
    } else {
      if (kDebugMode) {
        print('User denied permissions');
      }
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('Refresh');
      }
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);

      if (kDebugMode) {
        print(message.notification?.title.toString());
        print(message.notification?.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);
      }
        initLocalNotifications(context, message);

    });
  }



  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
        importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker'
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge:true,
        presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );



    Future.delayed(Duration.zero, (){
    _flutterLocalNotificationsPlugin.show(
    1, //id
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    notificationDetails
    );
    });


  }

  Future<void> setupInteractMessage(BuildContext context) async{

    //When App is Terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage!= null){
      handleMessage(context, initialMessage);
    }

    //When App is in Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }
  void handleMessage(BuildContext context, RemoteMessage message){
    if(message.data['type'] == 'msg'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlansTab() ));
    }

  }
}
