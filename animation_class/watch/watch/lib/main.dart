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
  final redValue = Random().nextDouble() * 2.0;
  final greenalue = Random().nextDouble() * 2.0;
  final blueValue = Random().nextDouble() * 2.0;

  @override
  State<AppleWatch> createState() => _AppleWatchState();
}

class _AppleWatchState extends State<AppleWatch>
    with SingleTickerProviderStateMixin {
  double redValue = Random().nextDouble() * 2.0;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
    lowerBound: 0.005,
    upperBound: 1.8,
  );

  void _onTap() {
    // setState(() {
    //   redValue = Random().nextDouble() * 2.0;
    //   print("_OnTap value = $redValue");
    //
    // });
    _animationController.forward();
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
                animation: _animationController,
                builder: (context, w) {
                  return CustomPaint(
                      painter: AppleWatchPainter(
                          redValue: _animationController.value,
                          greenValue: widget.greenalue,
                          blueValue: widget.blueValue),
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
