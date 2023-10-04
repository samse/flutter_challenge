import 'dart:math';

import 'package:flutter/material.dart';

class RotateBlock extends StatefulWidget {
  final Size size;
  final Color color;
  final int delay;
  const RotateBlock(
      {Key? key, required this.size, required this.color, required this.delay})
      : super(key: key);

  @override
  State<RotateBlock> createState() => _RotateBlockState();
}

class _RotateBlockState extends State<RotateBlock>
    with SingleTickerProviderStateMixin {
  late Color _color = widget.color;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);
  late final animRotate = Tween(begin: 0.0, end: 1.0).animate(_controller);
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(Duration(seconds: 2), () {
          if (_color != Colors.transparent) {
            setState(() {
              _color = blockColor();
              print("Color : $_color");
            });
          }
          _controller.forward();
        });
      }
    });

    Future.delayed(
        Duration(milliseconds: widget.delay), () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animRotate, //animRotate,
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        color: _color,
      ),
    );
    // return Transform.rotate(
    //   angle: (random.nextInt(360) * 3.14159265359) / 180,
    //   child: Container(
    //     width: widget.size.width,
    //     height: widget.size.height,
    //     color: widget.color,
    //   ),
    // );
  }

  static final List<Color> _colors = [
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.orange,
    Colors.red,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
    Colors.cyan,
    Colors.grey,
  ];

  Color blockColor() {
    final index = random.nextDouble() * 20;
    return _colors[index.toInt()];
  }
}
