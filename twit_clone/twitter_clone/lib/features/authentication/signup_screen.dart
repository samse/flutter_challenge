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
import 'package:twitter_clone/features/authentication/password_screen.dart';
import 'package:twitter_clone/features/authentication/pincode_verify_screen.dart';
import 'package:twitter_clone/features/authentication/viewmodel/signup_view_model.dart';

import '../../common/widget_builder.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeURL = "/signUp";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  Map<String, dynamic>? _args;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _name = "";
  String _email = "";
  DateTime? _birthDate;
  String _birthDateStr = "";
  late bool _isShowDatePicker = false;

  @override
  void initState() {
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    super.initState();
  }

  void _toggleDatePicker(BuildContext context) {
    setState(() {
      _isShowDatePicker = !_isShowDatePicker;
    });
  }

  bool _isFulledInputData() {
    return _isNameValid() && _isEmailValid() && _isBirthValid();
  }

  bool _isNameValid() {
    return _name.isNotEmpty;
  }

  bool _isBirthValid() {
    return _birthDateStr.isNotEmpty;
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

  void _onCancel(BuildContext context) {
    context.pop();
  }

  void _onNext() {
    final _param = {
      "name": _name,
      "email": _email,
      "birthDate": "${_birthDate?.millisecondsSinceEpoch ?? "0"}",
      "birthDateStr": _birthDateStr
    };

    ref.read(signUpForm.notifier).state = {
      "name": _name,
      "email": _email,
    };

    print("onNext: ${ref.read(signUpForm.notifier).state}");
    // context.pushNamed(CustomizedExperienceScreen.routeName,
    //     queryParameters: _param);
    context.pushNamed(PasswordScreen.routeName, queryParameters: _param);
  }

  void _onSignUp() {
    final _param = {
      "name": _name,
      "email": _email,
      "birthDate": "${_birthDate?.millisecondsSinceEpoch ?? "0"}",
      "birthDateStr": _birthDateStr
    };
    print("Signup onNext: $_param");
    //context.pushNamed(PinCodeVerifyScreen.routeName, queryParameters: _param);
    context.pushNamed(PasswordScreen.routeName, queryParameters: _param);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("_args : $_args");
    if (_args!.isNotEmpty) {
      _nameController.text = _args!["name"];
      _emailController.text = _args!["email"];
      _birthDateStr = _args!["birthDateStr"];
      //@@ 문자열로 전달받아서 DateTime형으로 변경 필요함.!! _birthDate = _args!["birthDate"];
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => _onCancel(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Cancel",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v40,
                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v10,
                TextField(
                  controller: _nameController,
                  autocorrect: false,
                  style: context.hintText,
                  decoration: InputDecoration(
                    hintText: "Name",
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
                          color: _isNameValid()
                              ? Colors.green
                              : Colors.transparent,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.v12,
                TextField(
                  controller: _emailController,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: context.hintText,
                  decoration: InputDecoration(
                    hintText: "Phone number of Email address",
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
                          color: _isEmailValid()
                              ? Colors.green
                              : Colors.transparent,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _toggleDatePicker(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                            _birthDateStr == ""
                                ? "Date of birth"
                                : _birthDateStr,
                            style: context.hintText
                                .copyWith(color: Colors.black54)),
                      ),
                      SizedBox(
                        width: 20,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FaIcon(
                            FontAwesomeIcons.circleCheck,
                            color: _birthDateStr == ""
                                ? Colors.transparent
                                : Colors.green,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.v10,
                Container(
                  width: size.width,
                  height: 1,
                  color: Colors.grey,
                ),
                Gaps.v4,
                const Text(
                  "This will not be shown publicy. Confirm your won age, even if this account is for a business, a pet, or something else.",
                  maxLines: 3,
                )
              ],
            ),
            if (_args!.isNotEmpty)
              buildAlignSizedRichText(
                  align: Alignment.bottomLeft,
                  size: size,
                  texts: [
                    "By signing up, you agree to the ",
                    "Terms of Service",
                    " and ",
                    "Privacy Policy",
                    ", including ",
                    "Cookie Use",
                    ". Twitter may use yout contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. ",
                    "Learn more",
                    ". Others will be able to find you by email or  phone number, when provided, unless you choose otherwise ",
                    "here",
                    ".",
                  ],
                  defStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size18,
                  ),
                  highlightStyle:
                      const TextStyle(color: Colors.lightBlueAccent)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: _args!.isNotEmpty
            ? buildSignUpButton(context, size)
            : buildDatePicker(context),
        //: buildNextButton(context, size),
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: _isShowDatePicker ? (200 + 62) : 62,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildNextButton(context, size),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          if (_isShowDatePicker)
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (newDateTime) {
                    print("new date time: $newDateTime");
                    _birthDate = newDateTime;
                    _birthDateStr =
                        "${newDateTime.year}년 ${newDateTime.month}월 ${newDateTime.day}일";
                    setState(() {});
                  }),
            ),
        ],
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context, Size size) {
    return GestureDetector(
      onTap: _onSignUp,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    _isFulledInputData() ? Colors.white : Colors.grey.shade100,
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        height: 60,
        width: size.width,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: _onNext,
          child: Container(
            decoration: BoxDecoration(
              color: _isFulledInputData() ? Colors.black : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  color: _isFulledInputData()
                      ? Colors.white
                      : Colors.grey.shade100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
