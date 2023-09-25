import 'package:final_prj/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/gaps.dart';
import '../model/post_model.dart';
import '../widget/post_view.dart';

class MoodListScreen extends ConsumerStatefulWidget {
  const MoodListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MoodListScreen> createState() => _MoodListScreenState();
}

class _MoodListScreenState extends ConsumerState<MoodListScreen> {
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
