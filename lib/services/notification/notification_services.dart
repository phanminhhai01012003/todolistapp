import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/common/utils.dart';
import 'package:todolistapp/models/notification.dart';
import 'package:todolistapp/services/notification/notification_data.dart';
import 'package:todolistapp/views/menu/todo/completed_task_detail.dart';
import 'package:todolistapp/views/menu/todo/progress_task_detail.dart';

class NotificationServices {
  static final userCollection = FirebaseFirestore.instance.collection("user");
  static final user = FirebaseAuth.instance.currentUser;
  static final appBox = Hive.box("app_settings");
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final notifyData = NotificationData();
  static final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final firebaseMessaging = FirebaseMessaging.instance;
  static const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  static const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true
  );
  static const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings
  );
  static const androidNotificationDetails = AndroidNotificationDetails(
    "123456789", 
    "To do list notification channels",
    channelDescription: "To do list notifications",
    importance: Importance.max,
    playSound: true,
    priority: Priority.defaultPriority,
    ticker: "Ticker"
  );
  static const iosNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true
  );
  static const notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosNotificationDetails
  );
  static Future<void> initNotifications() async{
    tz.initializeTimeZones();
    await firebaseMessaging.requestPermission(
      provisional: true,
      alert: true,
      badge: true,
      sound: true,
      announcement: true
    ).then((response) async{
      final fcmToken = await firebaseMessaging.getToken();
      saveTokenToLocal(fcmToken ?? "");
      print("Token: $fcmToken");
      if (response.authorizationStatus == AuthorizationStatus.authorized){
        print("Permission granted");
        await initLocalNotifications();
      } else {
        print("Permission denied");
      }
    });
  }
  static Future initLocalNotifications() async{
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        handleClickNotification(jsonDecode(details.payload!) as Map<String, dynamic>);
      },
    ).then((value) => print(value ?? false));
  }
  static Future initPushNotifications() async{
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      if(message.notification != null){
        final title = message.notification?.title ?? "N/A";
        final body = message.notification?.body ?? "N/A";
        final payLoad = message.data;
        final androidImage = message.notification?.android?.imageUrl ?? "N/A";
        final iosImage = message.notification?.apple?.imageUrl ?? "N/A";
        showNotification(title: title, body: body, payload: json.encode(payLoad));
        await saveNotification(title, body, androidImage, iosImage);
      }
    });
    listenNotification();
  }
  static Future listenNotification() async{
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await firebaseMessaging.getInitialMessage().then((message){
      if (message!.data.isNotEmpty){
        handleNotification(message);
      }
    });
  } 
  static void handleNotification(RemoteMessage? message){
    if(message == null) return;
    handleClickNotification(message.data);
  }
  static void handleClickNotification(Map<String, dynamic> data) {
    if (data['data']['status'] == 'Progress'){
      navigatorKey.currentState!.push(pageRoute(ProgressTaskDetail(todo: data['data'])));
    } else {
      navigatorKey.currentState!.push(pageRoute(CompletedTaskDetail(todo: data['data'])));
    }
  }
  static Future<void> saveNotification(
    String title, 
    String body,
    String androidImage,
    String iosImage
  ) async {
    NotificationModel notify = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toRadixString(2), 
      title: title, 
      body: body,
      androidImageUrl: androidImage,
      iosImageUrl: iosImage, 
      isRead: false, 
      createdAt: DateTime.now()
    );
    await notifyData.saveNotification(notify);
  }
  static void showNotification({
    required String title,
    required String body,
    required String payload,
  }){
    flutterLocalNotificationsPlugin.show(
      generateRandomInt(2147483647), 
      title, 
      body, 
      notificationDetails,
      payload: payload
    );
  }
  static void scheduleNotification({
    required String title,
    required String body,
    required DateTime time
  }){
    flutterLocalNotificationsPlugin.zonedSchedule(
      generateRandomInt(2147483647), 
      title, 
      body, 
      tz.TZDateTime.from(time, tz.local), 
      notificationDetails, 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
  static void cancelNotification(int id) => flutterLocalNotificationsPlugin.cancel(id);
  static Future<void> saveTokenToLocal(String token) async{
    try {
      appBox.put("token", token);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  static Future<void> saveTokenToFirebase(String token) async{
    try {
      await userCollection.doc(user!.uid).update({"token": token});
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
    try{
      print("Handling a background message ${message.messageId}");
      print("Message data: ${message.data}");
      handleNotification(message);
    }catch(e){
      print("Error to handle: $e");
      rethrow;
    }
  }
}