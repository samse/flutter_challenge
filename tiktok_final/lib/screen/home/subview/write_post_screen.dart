import 'package:final_prj/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/gaps.dart';
import '../../../common/widget/fancy_button.dart';
import '../model/post_model.dart';

class WritePostScreen extends ConsumerStatefulWidget {
  const WritePostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends ConsumerState<WritePostScreen> {
  TextEditingController _controller = TextEditingController();
  String comment = "";

  List<Icon> icons = [
    PostModel.moodIcon(MoodType.smile_1),
    PostModel.moodIcon(MoodType.smile_2),
    PostModel.moodIcon(MoodType.smile_3),
    PostModel.moodIcon(MoodType.shy),
    PostModel.moodIcon(MoodType.eyedrop),
    PostModel.moodIcon(MoodType.angry),
    PostModel.moodIcon(MoodType.freakedout),
    PostModel.moodIcon(MoodType.obite),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      comment = _controller.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            Text(
              "How do you feel?",
              style: context.textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Gaps.v12,
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black, // 그림자 색상
                      spreadRadius: 0, // 그림자 확산 범위
                      blurRadius: 1, // 그림자 흐림 정도
                      offset: Offset(-2, 4), // 그림자 위치 (x, y)
                    )
                  ]),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10, left: 20),
                  hintText: "Write it down here!",
                  hintStyle: context.hintText,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Gaps.v32,
            Text(
              "What's your mood?",
              style: context.textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Gaps.v12,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final icon in icons)
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black, // 그림자 색상
                            spreadRadius: 0, // 그림자 확산 범위
                            blurRadius: 1, // 그림자 흐림 정도
                            offset: Offset(0, 2), // 그림자 위치 (x, y)
                          )
                        ]),
                    child: icon,
                  ),
              ],
            ),
            Gaps.v40,
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: FancyButton(
                    text: "Post",
                    style: context.buttonTitle,
                    color: Colors.purple.shade100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
