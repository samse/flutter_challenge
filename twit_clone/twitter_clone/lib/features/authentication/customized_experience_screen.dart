import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';
import 'package:twitter_clone/features/authentication/signup_screen.dart';

import '../../common/widget_builder.dart';

class CustomizedExperienceScreen extends StatefulWidget {
  static const routeURL = "/custExp";
  static const routeName = "custExp";
  const CustomizedExperienceScreen({super.key});

  @override
  State<CustomizedExperienceScreen> createState() =>
      _CustomizedExperienceScreenState();
}

class _CustomizedExperienceScreenState
    extends State<CustomizedExperienceScreen> {
  Map<String, dynamic>? _args;
  void _onNext(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName, queryParameters: _args ?? {});
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("arguments : ${_args ?? ""}");
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 40.0,
          right: 40.0,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                const Text(
                  "Customized your \nexperience",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v28,
                const Text(
                  "Track where you see Twitter content across the web",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v24,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      const Flexible(
                        flex: 4,
                        child: Text(
                          "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, of phone number.",
                          maxLines: 10,
                          style: TextStyle(
                            fontSize: Sizes.size18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: CupertinoSwitch(
                          value: true,
                          onChanged: (bool value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.v40,
                buildRichText(
                  texts: [
                    "By signing up, you agree to our ",
                    "Terms, Privacy Policy",
                    ", and ",
                    "Cookie Use.",
                    " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Polycy. ",
                    "Learn more",
                  ],
                  defStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size18,
                  ),
                  highlightStyle:
                      const TextStyle(color: Colors.lightBlueAccent),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => _onNext(context),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
