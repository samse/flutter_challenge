import 'package:flutter/material.dart';
import 'package:toonflix2/screens/test_screen.dart';
import 'package:toonflix2/services/api_services.dart';

import 'screens/home_screen.dart';

void main() {
  ApiServices.getTodaysToons();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // home: const TestScreen(),
    );
  }
}
