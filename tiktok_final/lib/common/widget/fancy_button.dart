import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  Widget? trailing;
  FancyButton(
      {Key? key,
      required this.text,
      required this.style,
      required this.color,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 2,
          ),
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Colors.black, // 그림자 색상
              spreadRadius: 1, // 그림자 확산 범위
              blurRadius: 1, // 그림자 흐림 정도
              offset: Offset(2, 2), // 그림자 위치 (x, y)
            ),
          ]),
      child: Center(
        child: trailing == null
            ? Text(text, style: style)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(text, style: style), trailing!],
              ),
      ),
    );
  }
}
