import 'dart:math';

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
      title: 'Apple watch',
      home: AppleWatch(title: 'Flutter Demo Home Page'),
    );
  }
}

class AppleWatch extends StatefulWidget {
  AppleWatch({super.key, required this.title});
  final String title;

  @override
  State<AppleWatch> createState() => _AppleWatchState();
}

class _AppleWatchState extends State<AppleWatch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  )..forward();

  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

  late Animation<double> _redProgress =
      Tween(begin: 0.001, end: Random().nextDouble() * 2.0).animate(_curve);
  late Animation<double> _blueProgress =
      Tween(begin: 0.001, end: Random().nextDouble() * 2.0).animate(_curve);
  late Animation<double> _greenProgress =
      Tween(begin: 0.001, end: Random().nextDouble() * 2.0).animate(_curve);

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _animationController.forward();
  }

  void _onTap() {
    setState(() {
      _redProgress = Tween(
        begin: _redProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
      _blueProgress = Tween(
        begin: _blueProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
      _greenProgress = Tween(
        begin: _greenProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedBuilder(
                animation: _redProgress,
                builder: (context, w) {
                  return CustomPaint(
                      painter: AppleWatchPainter(
                          redValue: _redProgress.value,
                          greenValue: _blueProgress.value,
                          blueValue: _greenProgress.value),
                      size: const Size(300, 300));
                }),
            GestureDetector(
              onTap: _onTap,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.cyan,
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final barWidth = 28.0;
  final barPeriod = 4.0;

  late double? redValue;
  late double? greenValue;
  late double? blueValue;

  AppleWatchPainter({this.redValue, this.greenValue, this.blueValue});

  @override
  void paint(Canvas canvas, Size size) {
    final centerOffset = Offset(size.width / 2, size.height / 2);

    final nPaint = Paint()
      ..color = Colors.red.shade900.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;

    final arcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;

    final redSize = size.width - 30;
    drawArcBar(
        canvas: canvas,
        arcRect: Rect.fromCenter(
            center: centerOffset, width: redSize, height: redSize),
        paint: nPaint,
        arcPaint: arcPaint,
        value: redValue ?? -0.4);

    nPaint.color = Colors.green.shade900.withOpacity(0.5);
    arcPaint.color = Colors.green.shade400;
    final greenSize = redSize - barWidth * 2 - 10;
    drawArcBar(
        canvas: canvas,
        arcRect: Rect.fromCenter(
            center: centerOffset, width: greenSize, height: greenSize),
        paint: nPaint,
        arcPaint: arcPaint,
        value: greenValue ?? -0.4);
    nPaint.color = Colors.cyan.shade900.withOpacity(0.5);
    arcPaint.color = Colors.cyan.shade400;
    final blueSize = redSize - barWidth * 4 - 20;
    drawArcBar(
        canvas: canvas,
        arcRect: Rect.fromCenter(
            center: centerOffset, width: blueSize, height: blueSize),
        paint: nPaint,
        arcPaint: arcPaint,
        value: blueValue ?? -0.4);
  }

  void drawArcBar(
      {required Canvas canvas,
      required Rect arcRect,
      required Paint paint,
      required Paint arcPaint,
      required double value}) {
    print("drawArcBar : $value");
    canvas.drawArc(arcRect, -0.5 * pi, 2 * pi, false, paint);
    canvas.drawArc(arcRect, -0.5 * pi, value * pi, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
