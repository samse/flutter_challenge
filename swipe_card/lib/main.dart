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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Offset xPos = Offset(0, 0);
  late Size size = MediaQuery.of(context).size;

  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: -size.width,
      upperBound: size.width,
      value: 0);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    print("details: $details");
    _animationController.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _animationController.animateTo(0, curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) =>
                          _onHorizontalDragUpdate(details),
                      onHorizontalDragEnd: (details) =>
                          _onHorizontalDragEnd(details),
                      child: Transform.translate(
                        offset: Offset(
                            _animationController.value, 0), //Offset(xPos, 0),
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
              );
            }));
  }
}
