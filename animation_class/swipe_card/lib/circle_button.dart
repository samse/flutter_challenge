import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  final Size size;
  CircleButton({
    super.key,
    required this.color,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width / 2),
        border: Border.all(width: 4, color: Colors.white),
        color: color,
      ),
      child: icon,
    );
  }
}
