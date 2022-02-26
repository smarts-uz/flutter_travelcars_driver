import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_travelcars_driver/src/model/task_model.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.iOS),
      home: const MainScreen(),
    );
  }
}
