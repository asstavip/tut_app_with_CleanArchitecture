import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/theme_manager.dart';

class MyApp extends StatefulWidget {
  int counter = 0;
  MyApp._internal();// internal constructor

  static final MyApp instance = MyApp._internal(); // static instance

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
