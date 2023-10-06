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
                    guageValue: 9,
                    min: 0,
                    max: 10,
                  ),
                ),
                Center(
                  child: Text(
                    "3:00",
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
                  Icon(
                    Icons.play_circle,
                    size: 80,
                    color: Colors.red,
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
