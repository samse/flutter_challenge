import 'dart:math';

import 'package:block_anim/block.dart';
import 'package:flutter/material.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, // 그리드 열의 수
            crossAxisSpacing: 10.0, // 열 사이의 간격
            mainAxisSpacing: 10.0, // 행 사이의 간격
          ),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: Block(
                size: const Size(60, 60),
                color: blockColor(index),
              ),
            );
          },
        ),
      ),
    );
  }

  static final List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
  ];
  Color blockColor(int index) {
    return _colors[index % 20];
  }
}
