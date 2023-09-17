import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';
import 'package:twitter_clone/features/authentication/customized_experience_screen.dart';
import 'package:twitter_clone/features/authentication/pincode_verify_screen.dart';
import 'package:twitter_clone/features/authentication/signup_screen.dart';
import 'package:twitter_clone/features/authentication/viewmodel/signup_view_model.dart';
import 'package:twitter_clone/features/authentication/widget/form_button.dart';
import 'package:twitter_clone/features/authentication/widget/password_field.dart';
import 'package:twitter_clone/features/home/home_screen.dart';

import '../../common/widget_builder.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeURL = "/signIn";
  static const routeName = "signIn";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  Map<String, dynamic>? _args;
  final TextEditingController _emailController = TextEditingController();
  String _email = "";
  String _password = "";
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    super.initState();
  }

  bool _isEmailValid() {
    if (_email.isEmpty) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regExp.hasMatch(_email)) {
      return true;
    }
    return false;
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onSignIn(BuildContext context) async {
    if (_email.isEmpty || _password.isEmpty) {
      context.showAlert(
          title: "",
          message: "이메일과 페스워드를 모두 입력하셔야죠!",
          positiveCallback: () => {});
      return;
    }
    final res = await ref
        .read(singUpProvider.notifier)
        .signIn(context: context, email: _email, password: _password);
    if (res) {
      context.goNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v80,
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: 1.7,
                      child: const FaIcon(
                        FontAwesomeIcons.at,
                        size: Sizes.size40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v80,
              TextField(
                controller: _emailController,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                style: context.hintText,
                decoration: InputDecoration(
                  hintText: "Email address",
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
                  suffixIcon: SizedBox(
                    width: 20,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FaIcon(
                        FontAwesomeIcons.circleCheck,
                        color:
                            _isEmailValid() ? Colors.green : Colors.transparent,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v24,
              PasswordField(
                  obscureText: _obscureText,
                  hintText: "Password",
                  controller: _passwordController,
                  isVerified: _isPasswordValid()),
              Gaps.v10,
              GestureDetector(
                  onTap: () {
                    _onSignIn(context);
                  },
                  child: FormButton(disabled: false, text: "Log In")),
              Gaps.v20,
              const Center(child: Text("Forgot password?")),
              Expanded(
                  child: Stack(children: [
                Positioned(
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(SignUpScreen.routeName);
                    },
                    child: Container(
                      height: 50,
                      width: size.width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: Center(child: Text("Create Account")),
                    ),
                  ),
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
