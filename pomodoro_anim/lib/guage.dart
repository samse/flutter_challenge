import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';

class Guage extends StatefulWidget {
  final double guageValue;
  late double? min;
  late double? max;

  Guage({Key? key, required this.guageValue, this.min = 0, this.max = 1})
      : super(key: key);

  @override
  State<Guage> createState() => _GuageState();
}

class _GuageState extends State<Guage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation curve =
      CurvedAnimation(parent: _controller, curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GuagePainter(
          guageValue: widget.guageValue,
          minValue: widget.min!,
          maxValue: widget.max!),
    );
  }
}

class GuagePainter extends CustomPainter {
  final maxGuageValue = 2.0; // 실제 게이지 최대값 0 ~ 2.0
  final barWidth = 24.0;
  final double guageValue;
  final double minValue;
  final double maxValue;

  GuagePainter({
    required this.guageValue,
    required this.minValue,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerOffset = Offset(size.width / 2, size.height / 2);
    final nPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
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
        value: computeGuageValue());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // min, max 범위와 실제값을 가지고 0~2.0범위의 실제 게이지 값을 반환한다.
  double computeGuageValue() {
    double range = maxValue - minValue;
    double realValue = (max(guageValue - minValue, 0)) * maxGuageValue / range;
    return realValue;
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
}
