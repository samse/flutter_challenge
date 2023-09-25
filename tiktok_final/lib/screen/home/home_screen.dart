import 'package:final_prj/app.dart';
import 'package:final_prj/screen/home/widget/post_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/gaps.dart';
import 'model/post_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> posts = [
    PostModel(
        moodType: MoodType.smile_1,
        comment: '안녕 오늘은 날씨가 이래서 그런지 꼬물꼬물.. 느낌이 아주 이상하네',
        createdAt: (DateTime.now().millisecondsSinceEpoch - 1987219)),
    PostModel(
        moodType: MoodType.smile_1,
        comment: '안녕 오늘은 날씨가 ',
        createdAt: (DateTime.now().millisecondsSinceEpoch - 1987219))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade100,
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
      body: Column(
        children: [
          Gaps.v40,
          for (final post in posts)
            Post(
              postModel: post,
              style: context.normal,
            ),
        ],
      ),
    );
  }
}
