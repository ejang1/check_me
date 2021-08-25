//import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();
  factory NotificationService(){
    return _notificationService;
  }

  Future<void> init() async{
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async{
      },
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async{
          if(payload != null){
            print('notification payload: $payload');
          }
        });
  }

  void scheduledAlarm() async {
    tz.initializeTimeZones();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'temp id', 'temp name', 'temp description',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    const IOSNotificationDetails iOSNotificationDetails =
    IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "temp",
        "Temp body",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
    );
  }
  NotificationService._internal();
}