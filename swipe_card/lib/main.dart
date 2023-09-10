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

  Tween<double> _scaleTween = Tween(begin: 0.8, end: 1.0);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // print("dragging details: $details");
    _animationController.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    print(
        "_onHorizontalDragEnd: ${_animationController.value.abs()} / ${size.width}");
    double movement = _animationController.value.abs();
    print("$movement > ${size.width / 4}");
    if (movement > (size.width / 4)) {
      print("set to invisible");
      _animationController.animateTo(_animationController.value +
          (_animationController.value.isNegative ? -200 : 200));
    } else {
      print("set to 0");
      _animationController.animateTo(0, curve: Curves.decelerate);
    }
  }

  double maxAngle = 0.7;
  double _rotateValue(double delta) {
    // wv : width = av : angle
    // av = wv * angle / width
    print("_rotateValue ($delta)");
    return delta * maxAngle / _animationController.upperBound;
  }

  double _scaleValue() {
    print("_ScaleValue");
    return _scaleTween.transform(
        _animationController.value.abs() / _animationController.upperBound);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // final scale = _scaleTween.transform(
    //     _animationController.value.abs() / _animationController.upperBound);
    print("pos: ${_animationController.value}");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final _scale = _scaleValue();

              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 100,
                    child: Transform.scale(
                      scale: _scale,
                      child: Material(
                        elevation: 10,
                        color: Colors.amber,
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                        ),
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
                        offset: Offset(_animationController.value, 0),
                        child: Transform.rotate(
                          // offset: Offset(
                          //     _animationController.value, 0), //Offset(xPos, 0),
                          angle: _rotateValue(_animationController.value),
                          origin: Offset(0, size.height),
                          child: Material(
                            elevation: 10,
                            color: Colors.orange,
                            child: SizedBox(
                              width: size.width * 0.8,
                              height: size.height * 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
