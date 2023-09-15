import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';

import '../../../common/gaps.dart';
import '../../../common/sizes.dart';

class PasswordField extends StatefulWidget {
  String password = "";
  late bool obscureText;
  final TextEditingController controller;
  final String hintText;
  final bool isVerified;

  PasswordField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.isVerified});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  void _onClearTap() {
    setState(() {
      widget.controller.text = "";
    });
  }

  void _toggleObscureText() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      autocorrect: false,
      style: context.hintText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _toggleObscureText,
              child: FaIcon(
                widget.obscureText
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                color: Colors.grey.shade500,
                size: Sizes.size20,
              ),
            ),
            Gaps.h10,
            if (widget.isVerified)
              GestureDetector(
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: Sizes.size28,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
