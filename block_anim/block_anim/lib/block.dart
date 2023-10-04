import 'dart:math';

import 'package:flutter/material.dart';

class Block extends StatefulWidget {
  final Size size;
  final Color color;
  Block({super.key, required this.size, required this.color});

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> with SingleTickerProviderStateMixin {
  final random = Random();
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedTransition(
          rect: RelativeRectTween(
            begin: RelativeRect.fromLTRB(10, 10, 0, 0),
            end: nextRect(),
          ).animate(_controller),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: ScaleTransition(
                scale: Tween(begin: nextScale(), end: nextScale())
                    .animate(_controller),
                child: Transform.rotate(
                  angle: nextAngle(),
                  // turns: Tween(begin: nextAngle(), end: nextAngle())
                  //     .animate(_controller),
                  child: Container(
                    width: widget.size.width,
                    height: widget.size.height,
                    decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  RelativeRect nextRect() {
    double x = random.nextDouble() * 20.0;
    double y = random.nextDouble() * 20.0;
    return RelativeRect.fromLTRB(x, y, 0, 0);
  }

  double nextScale() {
    return max(random.nextDouble(), 0.6);
  }

  // 최대 90도의 랜덤 각도 리턴
  double nextAngle() {
    // return min(random.nextDouble(), 0.3);
    return (random.nextInt(300) * 3.14159265359) / 180;
  }
}
