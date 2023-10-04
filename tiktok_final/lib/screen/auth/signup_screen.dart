import 'package:final_prj/app.dart';
import 'package:final_prj/screen/auth/repo/authentication_repo.dart';
import 'package:final_prj/screen/auth/viewmodel/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../common/gaps.dart';
import '../../common/widget/auth_input_field.dart';
import '../../common/widget/fancy_button.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeURL = "/signUp";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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

  bool isCurrUserLoggedIn(String email) {
    final _authRepo = ref.read(authRepo);
    if (_authRepo.user != null) {
      if (_authRepo.user!.email == email && _authRepo.user!.emailVerified) {
        return true;
      }
    }
    return false;
  }

  void _onSignUp(BuildContext context) async {
    if (!_isEmailValid() || !_isPasswordValid()) {
      context.showAlert(
        message: "Email or password are not valid!",
      );
      return;
    }
    print("register : $_email /$_password");
    // print("${ref.read(authRepo).user}");
    // print("current user: ${ref.read(authRepo).user!.email}");
    final _authRepo = ref.read(authRepo);
    if (_authRepo.user == null) {
      // 가입 -> 이메일 전송
      _registerUser();
    } else {
      if (_authRepo.user!.email == _email) {
        if (_authRepo.user!.emailVerified == false) {
          // 이메일 전송
          _sendEmail();
        } else {
          // 동일 메일로 이메일인증까지 완료돤 유저 -> 로그인으로 이동
          context.showAlert(
              message: "이미 가입된 계정입니다. 로그인으로 이동합니다.",
              positiveCallback: () {
                context.go(LoginScreen.routeName);
              });
        }
      } else {
        // 현재 로그인유저와 가입유저가 다름
        // 가입 -> 이메일 전송
        _registerUser();
      }
    }
  }

  void _registerUser() async {
    final res = await ref
        .read(singUpProvider.notifier)
        .signUp(context, _email, _password);
    if (res) {
      _sendEmail();
    }
  }

  void _sendEmail() async {
    if (context.mounted) {
      bool ret = await ref
          .read(singUpProvider.notifier)
          .sendEmailVerification(context);
      if (ret) {
        if (context.mounted) {
          context.showAlert(
              message: "가입이 성공적으로 완료되었습니다. 인증메일이 전송되었으니 인증 확인 후 다시 이용해주세요!",
              positiveCallback: () => context.goNamed(LoginScreen.routeName));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: AppBar(
        backgroundColor: context.colors.primary,
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
              GestureDetector(
                onTap: () => _onSignUp(context),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: FancyButton(
                      text: "Create Account",
                      style: context.buttonTitle,
                      color: context.colors.secondary),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => context.goNamed(LoginScreen.routeName),
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: FancyButton(
                      text: "Login",
                      trailing: const Icon(Icons.arrow_right_alt),
                      style: context.buttonTitle,
                      color: context.colors.secondary),
                ),
              ),
            ),
          ),
          if (ref.watch(singUpProvider).isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                    strokeWidth: 3, backgroundColor: Colors.red),
              ),
            ),
        ],
      ),
    );
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
}
