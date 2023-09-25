import 'package:flutter/material.dart';

import '../../../common/gaps.dart';
import '../model/post_model.dart';

class Post extends StatelessWidget {
  final PostModel postModel;
  final TextStyle style;
  const Post({Key? key, required this.postModel, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("post: $postModel");

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                ),
                color: Colors.teal.shade300,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black, // 그림자 색상
                    spreadRadius: 1, // 그림자 확산 범위
                    blurRadius: 1, // 그림자 흐림 정도
                    offset: Offset(2, 2), // 그림자 위치 (x, y)
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Mood:  ",
                      style: style,
                    ),
                    moodIcon(postModel.moodType),
                  ],
                ),
                Text(
                  postModel.comment,
                  style: style,
                ),
              ],
            ),
          ),
          if (postModel.createdAt != null) Gaps.v8,
          if (postModel.createdAt != null)
            Text(
              timeWritten(postModel.createdAt!),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black26,
                fontWeight: FontWeight.w400,
              ),
            ),
          Gaps.v32,
        ],
      ),
    );
  }

  Icon moodIcon(MoodType type) {
    //TODO
    return Icon(Icons.person);
  }

  String timeWritten(int createdAt) {
    //TODO
    print("timeWritten");
    return "20m ago";
  }
}
