import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe card',
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
  Offset xPos = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                print("details: $details");
                setState(() {
                  xPos = xPos + details.delta;
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  xPos = Offset(0, 0);
                });
              },
              child: Transform.translate(
                offset: xPos, //Offset(xPos, 0),
                child: Material(
                  elevation: 10,
                  color: Colors.orange,
                  child: SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.5,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
