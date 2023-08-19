import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
              ),
              child: const Text("1"),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Text("2"),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("3")],
            ),
          ),
        ],
      ),
    );
  }
}
