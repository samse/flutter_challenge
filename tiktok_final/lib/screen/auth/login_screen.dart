import 'package:final_prj/app.dart';
import 'package:final_prj/common/gaps.dart';
import 'package:final_prj/common/widget/auth_input_field.dart';
import 'package:final_prj/screen/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/fancy_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeURL = "/signIn";
  static const routeName = "signIn";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _email = _emailController.text;
      print("email: $_email");
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
      print("password: $_password");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.fireFlameCurved,
              color: Colors.red,
              size: 20.0,
            ),
            Gaps.h6,
            Text(
              "MOOD",
              style: context.pageTitle,
            ),
            Gaps.h6,
            const FaIcon(FontAwesomeIcons.fireFlameCurved,
                color: Colors.red, size: 20.0),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v72,
              Center(
                child: Text(
                  "Welcome!",
                  style: context.pageTitle,
                ),
              ),
              Gaps.v32,
              SizedBox(
                width: 300,
                height: 50,
                child: AuthInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  hintTextStyle:
                      context.pageSubtitle.copyWith(color: Colors.black26),
                ),
              ),
              Gaps.v20,
              SizedBox(
                width: 300,
                height: 50,
                child: AuthInputField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  hintText: "Password",
                  hintTextStyle:
                      context.pageSubtitle.copyWith(color: Colors.black26),
                ),
              ),
              Gaps.v20,
              SizedBox(
                width: 300,
                height: 50,
                child: FancyButton(
                    text: "Enter",
                    style: context.buttonTitle,
                    color: Colors.purple.shade100),
              )
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => context.goNamed(SignUpScreen.routeName),
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: FancyButton(
                      text: "Create an account",
                      trailing: Icon(Icons.arrow_right_alt),
                      style: context.buttonTitle,
                      color: Colors.purple.shade100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
