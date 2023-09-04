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
      home: const AppleWatch(title: 'Flutter Demo Home Page'),
    );
  }
}

class AppleWatch extends StatefulWidget {
  const AppleWatch({super.key, required this.title});
  final String title;
  @override
  State<AppleWatch> createState() => _AppleWatchState();
}

class _AppleWatchState extends State<AppleWatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: CustomPaint(
          painter: AppleWatchPainter(),
          size: const Size(300, 300),
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final barWidth = 32.0;
  final barPeriod = 2.0;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    //canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final blackPaint = Paint()..color = Colors.black;
    final redPaint = Paint()..color = Colors.red.shade900.withOpacity(0.5);
    final greenPaint = Paint()..color = Colors.green.shade900;
    final bluePaint = Paint()..color = Colors.cyan.shade900;
    final offset = Offset(size.width / 2, size.height / 2);
    final halfWidth = size.width / 2;
    canvas.drawCircle(offset, halfWidth, redPaint);
    canvas.drawCircle(offset, halfWidth - barWidth, blackPaint);
    canvas.drawCircle(offset, halfWidth - barWidth - barPeriod, greenPaint);
    canvas.drawCircle(
        offset, halfWidth - (barWidth * 2) - barPeriod, blackPaint);
    canvas.drawCircle(
        offset, halfWidth - (barWidth * 2) - (barPeriod * 2), bluePaint);
    canvas.drawCircle(
        offset, halfWidth - (barWidth * 3) - (barPeriod * 2), blackPaint);

    final redArcRect = Rect.fromCenter(
        center: offset, width: size.width - 30, height: size.height - 30);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;
    canvas.drawArc(redArcRect, -0.5 * pi, 1.5 * pi, false, redArcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
