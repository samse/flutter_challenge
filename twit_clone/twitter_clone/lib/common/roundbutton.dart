import 'package:flutter/material.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/sizes.dart';

class RoundButton extends StatelessWidget {
  final String title;
  Size? size;
  RoundButton({super.key, required this.title, this.size});

  @override
  Widget build(BuildContext context) {
    return size != null
        ? SizedBox(
            width: size!.width,
            height: size!.height,
            child: makeButton(context))
        : makeButton(context);
  }

  Widget makeButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Center(
        child: Text(
          title,
          style: context.buttonTitle
              .copyWith(fontSize: Sizes.size16, color: Colors.grey),
        ),
      ),
    );
  }
}
