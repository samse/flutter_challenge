import 'package:flutter/material.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/sizes.dart';

class CustomizedExperienceScreen extends StatefulWidget {
  const CustomizedExperienceScreen({super.key});

  @override
  State<CustomizedExperienceScreen> createState() =>
      _CustomizedExperienceScreenState();
}

class _CustomizedExperienceScreenState
    extends State<CustomizedExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 40.0,
          right: 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            Text(
              "Customized your \nexperience",
              maxLines: 2,
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v28,
            Text(
              "Track where you see Twitter content across the web",
              maxLines: 2,
              style: TextStyle(
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v24,
            Text(
              "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, of phone number.",
              maxLines: 10,
              style: TextStyle(
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gaps.v40,
            RichText(
              text: TextSpan(
                text: "By signing up, you agree to our ",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size18,
                ),
                children: [
                  const TextSpan(
                    text: "Terms, Privacy Policy",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                  TextSpan(
                    text: ", and",
                    style: DefaultTextStyle.of(context).style,
                  ),
                  const TextSpan(
                    text: "Cookie Use.",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                  TextSpan(
                    text:
                        " Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Polycy. ",
                    style: DefaultTextStyle.of(context).style,
                  ),
                  const TextSpan(
                    text: "Learn more",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          child: Text("Next"),
        ),
      ),
    );
  }
}
