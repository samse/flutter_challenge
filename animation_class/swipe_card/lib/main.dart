import 'package:flutter/material.dart';

import 'card.dart';
import 'circle_button.dart';

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
  int cardIndex = 1;
  Offset xPos = Offset(0, 0);
  late Size size = MediaQuery.of(context).size;

  late final AnimationController _positionAnim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: -size.width,
      upperBound: size.width,
      value: 0);

  Tween<double> _scaleTween = Tween(begin: 0.8, end: 1.0);
  Tween<double> _opacity = Tween(begin: 0.1, end: 1.0);

  @override
  void dispose() {
    _positionAnim.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // print("dragging details: $details");
    _positionAnim.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) async {
    print("_onHorizontalDragEnd: ${_positionAnim.value.abs()} / ${size.width}");
    double movement = _positionAnim.value.abs();
    print("$movement > ${size.width / 4}");
    if (movement > (size.width / 4)) {
      print("set to invisible");
      _positionAnim
          .animateTo(_positionAnim.value +
              (_positionAnim.value.isNegative ? -200 : 200))
          .whenComplete(_whenCompleted);
    } else {
      print("set to 0");
      _positionAnim.animateTo(0, curve: Curves.decelerate);
    }
  }

  double maxAngle = 0.7;
  double _rotateValue(double delta) {
    // wv : width = av : angle
    // av = wv * angle / width
    return delta * maxAngle / _positionAnim.upperBound;
  }

  void _whenCompleted() {
    setState(() {
      cardIndex = cardIndex + 1;
      if (cardIndex > 5) {
        cardIndex = 1;
      }
      _positionAnim.value = 0;
    });
  }

  void _onTapLeft(BuildContext context) {
    print("TapLEFT ${_positionAnim.value}");
    _positionAnim.reverse().whenComplete(() {
      print("TapLEFT Completed ${_positionAnim.value}");
      _whenCompleted();
    });
  }

  void _onTapRight(BuildContext context) {
    print("TapRight ${_positionAnim.value}");
    _positionAnim.forward().whenComplete(() {
      print("TapRight Completed ${_positionAnim.value}");
      _whenCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("pos: ${_positionAnim.value}");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedBuilder(
            animation: _positionAnim,
            builder: (context, child) {
              final scale = _scaleTween.transform(
                  _positionAnim.value.abs() / _positionAnim.upperBound);
              print("_positionAnimValue: ${_positionAnim.value}");
              Color _leftColor = Colors.red.withOpacity(1.0);
              Color _rightColor = Colors.blue.withOpacity(1.0);
              final opacity = _opacity.transform(
                  _positionAnim.value.abs() / _positionAnim.upperBound);
              if (_positionAnim.value.isNegative) {
                _leftColor = Colors.red.withOpacity(opacity);
              } else if (_positionAnim.value > 0) {
                _rightColor = Colors.blue.withOpacity(opacity);
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: size.width,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: scale,
                        child: CoverCard(
                          index: (cardIndex == 5) ? 1 : (cardIndex + 1),
                        ),
                      ),
                      GestureDetector(
                        onHorizontalDragUpdate: (details) =>
                            _onHorizontalDragUpdate(details),
                        onHorizontalDragEnd: (details) =>
                            _onHorizontalDragEnd(details),
                        child: Transform.translate(
                          offset: Offset(_positionAnim.value, 0),
                          child: Transform.rotate(
                            // offset: Offset(
                            //     _animationController.value, 0), //Offset(xPos, 0),
                            angle: _rotateValue(_positionAnim.value),
                            origin: Offset(0, size.height),
                            child: CoverCard(index: cardIndex),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _onTapLeft(context),
                        child: CircleButton(
                          color: _leftColor,
                          icon: Icon(Icons.close, color: Colors.white),
                          size: Size(60, 60),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () => _onTapRight(context),
                        child: CircleButton(
                          color: _rightColor,
                          icon: Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                          ),
                          size: Size(60, 60),
                        ),
                      )
                    ],
                  )
                ],
              );
            }));
  }
}
