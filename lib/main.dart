import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/online_task_view_screen.dart';
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
}

put(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("fcmToken", token);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;
    put(token ?? "");
  });

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool check = true;

  @override
  void initState() {
    super.initState();
    var initializeSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    const IOSInitializationSettings initializeSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializeSettingsAndroid, iOS: initializeSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelected);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        String k =
            "MSID:${message.senderId}\nData: ${message.data} \nBody: ${notification!.body}";
        Map<String, dynamic> data = message.data;
        String id = data["id"].toString();
        if (android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            k,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: id,
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OnlineTaskViewScreen(
          //       id: message.data["id"].toString(),
          //     ),
          //   ),
          // );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnlineTaskViewScreen(
              id: message.data["id"].toString(),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> onSelected(payload) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OnlineTaskViewScreen(
          id: payload,
        ),
      ),
    );
  }

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
