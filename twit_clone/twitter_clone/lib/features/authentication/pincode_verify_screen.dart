import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';
import 'package:twitter_clone/common/widget_builder.dart';
import 'package:twitter_clone/features/authentication/password_screen.dart';

class PinCodeVerifyScreen extends StatefulWidget {
  static const routeURL = "/pincode";
  static const routeName = "pincode";

  const PinCodeVerifyScreen({super.key});

  @override
  State<PinCodeVerifyScreen> createState() => _PinCodeVerifyScreenState();
}

class _PinCodeVerifyScreenState extends State<PinCodeVerifyScreen> {
  Map<String, dynamic>? _args;
  String _pinCode = "";
  bool _isPincodeCompleted = false;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      print("${_controller.text}");
      if (_controller.text.length <= 6) {
        _pinCode = _controller.text;
        print("PinCode : $_pinCode");
      }
      if (_pinCode.length >= 6) {
        _isPincodeCompleted = true;
      } else {
        _isPincodeCompleted = false;
      }
      print("_isPincodeCompleted = $_isPincodeCompleted");
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext(BuildContext context) {
    context.pushNamed(PasswordScreen.routeName, queryParameters: _args ?? {});
  }

  @override
  Widget build(BuildContext context) {
    // get Arguments
    _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                Text(
                  "We sent you a code",
                  style: context.pageTitle,
                ),
                Gaps.v12,
                Text(
                  "Enter it below to verify \n${_args!["email"] ?? ""}.",
                  style: context.pageSubtitle,
                ),
                Gaps.v24,
                Stack(
                  children: [
                    buildPincodeView(context),
                    buildFakeTextField(context)
                  ],
                ),
                Gaps.v10,
                if (_isPincodeCompleted == true)
                  const Center(
                    child: Icon(
                      Icons.check_circle,
                      size: Sizes.size32,
                      color: Colors.green,
                    ),
                  )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Didn't receive email?",
                        style: context.textTheme.headlineSmall!
                            .copyWith(color: Colors.blue),
                      ),
                      Gaps.v10,
                      GestureDetector(
                        onTap: () {
                          if (_isPincodeCompleted) {
                            _onNext(context);
                          }
                        },
                        child: buildDisabledButton(
                            enabled: _isPincodeCompleted, context: context),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildFakeTextField(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          showCursor: false,
          style: const TextStyle(color: Colors.transparent),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildPincodeView(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < 6; i++) buildDigit(context, i),
        ],
      ),
    );
  }

  Widget buildDigit(BuildContext context, int index) {
    return SizedBox(
      width: 40,
      child: Column(
        key: Key("$index"),
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _pinCode.length > index ? _pinCode[index] : "",
            style: context.pincodeText,
          ),
          Container(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: MediaQuery.of(context).size.width,
      leading: const Stack(children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Center(
            child: Icon(
              Icons.arrow_back,
              size: Sizes.size28,
            ),
          ),
        ),
        Center(
            child: FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
        )),
      ]),
    );
  }
}
