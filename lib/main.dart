import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_sqlite/controller/task_controller.dart';
import 'package:todo_app_sqlite/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App with GetX',
      home: HomeScreen(),
    );
  }
}
