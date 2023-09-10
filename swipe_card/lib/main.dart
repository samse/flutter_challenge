import 'package:flutter/material.dart';

import 'card.dart';

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
          .whenComplete(() {
        setState(() {
          cardIndex = cardIndex + 1;
          if (cardIndex > 5) {
            cardIndex = 1;
          }
          _positionAnim.value = 0;
        });
      });
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
              print("Scale: $scale");

              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 100,
                    child: Transform.scale(
                      scale: scale,
                      child: CoverCard(
                        index: (cardIndex == 5) ? 1 : (cardIndex + 1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: GestureDetector(
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
                  ),
                ],
              );
            }));
  }
}
