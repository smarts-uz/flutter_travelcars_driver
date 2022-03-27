import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_travelcars_driver/src/ui/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> listMoney = [
  "Нет",
  "Наличными",
  "Онлайн UzCard",
  "Перечислением",
  "Онлайн VISA",
  "Онлайн MCard"
];

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'Travel',
  'uz.qwerty.travelcarsdrivers.util.service',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  return showNotification(message);
}

put(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("fcmToken", token);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future showNotification(RemoteMessage message) async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Travel',
    'uz.qwerty.travelcarsdrivers.util.service',
    importance: Importance.max,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  RemoteNotification? data = message.notification;

  AndroidNotification? android = data!.android;
  Map<String, dynamic> value = message.data;
  String id = value["id"];
  if (data != null) {
    flutterLocalNotificationsPlugin.show(
      0,
      data.title,
      data.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android!.smallIcon,
          setAsGroupSummary: true,
        ),
        iOS: const IOSNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      payload: id,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: const SplashScreen(),
    );
  }
}
