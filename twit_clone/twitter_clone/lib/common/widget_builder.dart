import 'package:flutter/material.dart';
import 'package:twitter_clone/common/sizes.dart';

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

Widget buildDisabledButton(
    {required bool enabled, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: enabled ? Colors.black : Colors.black45,
      ),
      child: const Center(
        child: Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
