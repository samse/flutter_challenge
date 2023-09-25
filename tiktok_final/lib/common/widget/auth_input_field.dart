import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final TextStyle hintTextStyle;
  bool? obscureText;

  AuthInputField({
    Key? key,
    this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.hintTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, left: 20),
        hintText: hintText,
        hintStyle: hintTextStyle,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
