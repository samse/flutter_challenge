import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Widget linearGradientText(
    {required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required List<Color> colors}) {
  final Shader linearGradientShader =
      ui.Gradient.linear(Offset(0, 20), Offset(150, 20), colors);

  return Text(text,
      style: TextStyle(
          foreground: Paint()..shader = linearGradientShader,
          fontSize: fontSize,
          fontWeight: fontWeight));
}
