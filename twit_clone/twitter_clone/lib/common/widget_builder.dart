import 'package:flutter/material.dart';

Widget buildRichText({
  required List<String> texts,
  required TextStyle defStyle,
  required TextStyle highlightStyle,
}) {
  return RichText(
    text: TextSpan(text: texts.first, style: defStyle, children: [
      for (var i = 1; i < texts.length; i++)
        TextSpan(text: texts[i], style: i % 2 == 1 ? highlightStyle : defStyle),
    ]),
  );
}

Widget buildAlignSizedRichText({
  required AlignmentGeometry align,
  required Size size,
  required List<String> texts,
  required TextStyle defStyle,
  required TextStyle highlightStyle,
}) {
  return Align(
    alignment: align,
    child: SizedBox(
      width: size.width,
      child: RichText(
        text: TextSpan(text: texts.first, style: defStyle, children: [
          for (var i = 1; i < texts.length; i++)
            TextSpan(
                text: texts[i], style: i % 2 == 1 ? highlightStyle : defStyle),
        ]),
      ),
    ),
  );
}
