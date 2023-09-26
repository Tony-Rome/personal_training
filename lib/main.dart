import 'package:flutter/material.dart';
import 'package:personal_training/pages/routine_detail_page.dart';
import 'package:personal_training/pages/home_page.dart';
import 'package:personal_training/pages/new_exercise_to_routine_page.dart';
import 'package:personal_training/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}