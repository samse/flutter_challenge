import 'dart:ui';

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
  PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentIndex = 0;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentIndex = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          switchInCurve: Curves.bounceIn,
          switchOutCurve: Curves.bounceOut,
          child: Container(
            key: ValueKey(_currentIndex),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/covers/${_currentIndex + 1}.jpg"),
              fit: BoxFit.cover,
            )),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black45,
              ),
            ),
          ),
        ),
        PageView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          onPageChanged: _onPageChanged,
          controller: _pageController,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.95,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 8),
                            blurRadius: 30,
                            spreadRadius: 2,
                            blurStyle: BlurStyle.normal)
                      ],
                      image: DecorationImage(
                          image: AssetImage("assets/covers/${index + 1}.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Interstella",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text("Hans Jimmer",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    )),
              ],
            );
          },
        ),
      ]),
    );
  }
}
