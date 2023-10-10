import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_card/data/girlgroup_viewmodel.dart';

import 'card.dart';
import 'data/girl_group.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Swipe card',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Swipe card'),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  int cardIndex = 0;
  Offset xPos = Offset(0, 0);
  late Size size = MediaQuery.of(context).size;
  late final List<GirlGroup> _groups;

  late final AnimationController _positionAnim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: -size.width,
      upperBound: size.width,
      value: 0);

  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  ); //..repeat(reverse: true);

  Tween<double> _scaleTween = Tween(begin: 0.8, end: 1.0);
  Tween<double> _opacity = Tween(begin: 0.1, end: 1.0);

  late final AnimationController _colorController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));
  late Animation _bgColorAnim =
      ColorTween(begin: Colors.cyan, end: Colors.amber)
          .animate(_colorController);

  @override
  void initState() {
    super.initState();
    _groups = ref.read(girlgroupProvider).value!;
  }

  @override
  void dispose() {
    _positionAnim.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // print("dragging details: $details");
    _positionAnim.value += details.delta.dx;
    // x : 400 = y : 1;
    // y = x / 400;
    _colorController.value = min(_positionAnim.value.abs() / 250, 1.0);
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
      _colorController.animateTo(0, curve: Curves.decelerate);
    }
  }

  double maxAngle = 0.7;
  double _rotateValue(double delta) {
    // wv : width = av : angle
    // av = wv * angle / width
    return delta * maxAngle / _positionAnim.upperBound;
  }

  void _whenCompleted() {
    List<GirlGroup> list = ref.read(girlgroupProvider).value!;
    setState(() {
      print("curr cardIndex : $cardIndex");
      cardIndex = cardIndex + 1;
      if (cardIndex >= 5) {
        cardIndex = 0;
      }
      print("next cardIndex : $cardIndex");
      // print(
      //     "color ${list[cardIndex].color} ==> ${list[cardIndex == 4 ? 0 : cardIndex + 1].color}");
      _progressController.animateTo((cardIndex + 1) * 0.2);
      _colorController.animateTo(1, curve: Curves.decelerate).whenComplete(() =>
          _bgColorAnim = ColorTween(
                  begin: list[cardIndex].color,
                  end: list[cardIndex == 4 ? 0 : cardIndex + 1].color)
              .animate(_colorController));

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
    // print("pos: ${_positionAnim.value}");
    return Scaffold(
        body: AnimatedBuilder(
            animation: _positionAnim,
            builder: (context, child) {
              final scale = _scaleTween.transform(
                  _positionAnim.value.abs() / _positionAnim.upperBound);
              // print("_positionAnimValue: ${_positionAnim.value}");
              // Color _leftColor = Colors.red.withOpacity(1.0);
              // Color _rightColor = Colors.blue.withOpacity(1.0);
              // final opacity = _opacity.transform(
              //     _positionAnim.value.abs() / _positionAnim.upperBound);
              // if (_positionAnim.value.isNegative) {
              //   _leftColor = Colors.red.withOpacity(opacity);
              // } else if (_positionAnim.value > 0) {
              //   _rightColor = Colors.blue.withOpacity(opacity);
              // }
              return AnimatedBuilder(
                animation: _bgColorAnim,
                builder: (context, child) {
                  return Container(
                    height: size.height,
                    color: _bgColorAnim.value,
                    child: Column(
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
                                girlGroup: _groups[
                                    (cardIndex == 4) ? 1 : (cardIndex + 1)],
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
                                  child:
                                      CoverCard(girlGroup: _groups[cardIndex]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, child) => CustomPaint(
                            size: Size(size.width - 80, 16),
                            painter: ProgressBar(
                              range: 5.0,
                              progressValue: _progressController.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }));
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;
  final double range;
  ProgressBar({
    required this.progressValue,
    required this.range,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
