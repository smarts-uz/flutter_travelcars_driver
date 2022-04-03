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
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'Travel',
  'uz.qwerty.travelcarsdrivers.util.service',
  importance: Importance.high,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      int _yourId = int.tryParse(message.data["id"]) ?? 0;
      Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => OnlineTaskViewScreen(
            id: _yourId.toString(),
          ),
        ),
      );
    },
  );
}
//
// AndroidNotificationChannel? channel;
// FlutterLocalNotificationsPlugin? flutterLocalNotifications;

put(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("fcmToken", token);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  // FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   sound: true,
  //   badge: true,
  // );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then(
    (value) {
      String? token = value;
      put(token ?? "");
      print(value);
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: const SplashScreen(),
    );
  }
}
