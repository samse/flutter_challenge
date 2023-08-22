import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';
import 'package:twitter_clone/features/signup_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeURL = "/";
  static const routeName = "onboard";

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Stack(
            children: [
              const Column(
                children: [
                  Gaps.v32,
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.lightBlueAccent,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Center(
                    child: Text(
                      "See what's happening \nin the world right now",
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 420,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Continue with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v12,
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Continue with Apple",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v12,
                      SizedBox(
                        height: 60,
                        child: Stack(
                          children: [
                            const Center(
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: 50,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                "or",
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const SignUpScreen();
                          // }));
                          context.pushNamed(SignUpScreen.routeName);
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          child: const Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.v28,
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: RichText(
                          text: const TextSpan(
                            text: "By signing up, You agree to our ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size18,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms, Privacy Policy",
                                style: TextStyle(color: Colors.lightBlueAccent),
                              ),
                              TextSpan(
                                text: ", and",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              TextSpan(
                                text: "Cookie Use.",
                                style: TextStyle(color: Colors.lightBlueAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v48,
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: RichText(
                          text: const TextSpan(
                            text: "Have an account aleady? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size18,
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(color: Colors.lightBlueAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v12,
                    ],
                  ),
                ),
              )
            ],
          )),
    ));
  }
}
