import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_anim/guage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pomodoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRunning = false;
  late Timer timer;
  late double goalSeconds = 60 * 3; // 3분
  late double elapsedSeconds = goalSeconds;

  @override
  void initState() {
    super.initState();
  }

  void _onTogglePlay() {
    isRunning = !isRunning;
    setState(() {});

    if (isRunning) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick,
      );
    }
  }

  void onTick(Timer timer) {
    elapsedSeconds = elapsedSeconds - 1;
    if (elapsedSeconds <= 0) {
      // completed
      timer.cancel();
      elapsedSeconds = goalSeconds;
    }
    setState(() {});
  }

  String formatElapsedSeconds() {
    var duration = Duration(seconds: elapsedSeconds.toInt());
    return "${duration.toString().split(".").first.substring(2, 4)}:${duration.toString().split(".").first.substring(5, 7)}";
  }

  // String formatRestMin(int seconds) {
  //   var duration = Duration(seconds: seconds);
  //   return duration.toString().split(".").first.substring(2, 4);
  // }
  //
  // String formatRestSeconds(int seconds) {
  //   var duration = Duration(seconds: seconds);
  //   return duration.toString().split(".").first.substring(5, 7);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            child: Stack(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Guage(
                    guageValue: goalSeconds - elapsedSeconds,
                    min: 0,
                    max: goalSeconds,
                  ),
                ),
                Center(
                  child: Text(
                    formatElapsedSeconds(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: Row(),
          ),
          Center(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 20.0),
                    child: Icon(
                      Icons.refresh,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onTogglePlay,
                    child: Icon(
                      isRunning ? Icons.pause_circle : Icons.play_circle,
                      size: 80,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Icon(
                      Icons.stop,
                      size: 40,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
