import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/widget_builder.dart';
import 'package:twitter_clone/features/authentication/interest_screen.dart';
import 'package:twitter_clone/features/authentication/widget/password_field.dart';

class PasswordScreen extends StatefulWidget {
  static const routeURL = "/password";
  static const routeName = "password";
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  Map<String, dynamic>? _args;
  String _password = "";
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void _onNext(BuildContext context) {
    context.pushNamed(InterestsScreen.routeName, queryParameters: _args ?? {});
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v64,
                const Center(
                    child: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                )),
                Gaps.v32,
                Text(
                  "You'll need a password",
                  style: context.pageTitle,
                ),
                Gaps.v12,
                Text(
                  "Make sure it's 8 charactores or more.",
                  style: context.pageSubtitle,
                ),
                Gaps.v24,
                PasswordField(
                    obscureText: _obscureText,
                    hintText: "Password",
                    controller: _passwordController,
                    isVerified: _isPasswordValid()),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      if (_isPasswordValid()) {
                        _onNext(context);
                      }
                    },
                    child: buildDisabledButton(
                        enabled: _isPasswordValid(), context: context),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
