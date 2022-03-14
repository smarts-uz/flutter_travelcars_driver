import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/task_model.dart';
import 'package:flutter_travelcars_driver/src/ui/splash/splash_screen.dart';

List<TaskModel> data = [
  TaskModel(
    check: false,
    place1: "Toshkent",
    place2: "Buxoro",
    status: "Статус",
  ),
  TaskModel(
    check: false,
    place1: "Toshkent",
    place2: "Buxoro",
    status: "Статус",
  ),
  TaskModel(
    check: false,
    place1: "Toshkent",
    place2: "Buxoro",
    status: "Статус",
  ),
  TaskModel(
    check: false,
    place1: "Toshkent",
    place2: "Buxoro",
    status: "Статус",
  ),
  TaskModel(
    check: false,
    place1: "Toshkent",
    place2: "Buxoro",
    status: "Статус",
  ),
];

void main() {
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
