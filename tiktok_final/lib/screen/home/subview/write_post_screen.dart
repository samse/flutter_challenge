import 'package:final_prj/app.dart';
import 'package:final_prj/screen/auth/repo/authentication_repo.dart';
import 'package:final_prj/screen/home/viewmodel/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/gaps.dart';
import '../../../common/widget/fancy_button.dart';
import '../model/post_model.dart';

class WritePostScreen extends ConsumerStatefulWidget {
  final TabController tabController;
  const WritePostScreen(this.tabController, {Key? key}) : super(key: key);

  @override
  ConsumerState<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends ConsumerState<WritePostScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  String _comment = "";
  String _mood = "";
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _comment = _controller.text;
    });
    _focusNode.addListener(() {
      setState(() {
        isKeyboardVisible = _focusNode.hasFocus;
        print("isKeyboardVisible : $isKeyboardVisible");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onPost(BuildContext context) async {
    if (_comment.isEmpty) {
      context.showAlert(message: "기분이 어떤지 먼저 입력해주세요!");
      return;
    }
    if (_mood.isEmpty) {
      context.showAlert(message: "지금 기분을 아이콘으로 선택해주세요!");
      return;
    }

    _focusNode.unfocus();

    final owner = ref.read(authRepo).user!.uid;
    await ref
        .read(postProvider.notifier)
        .addPost(PostModel(owner: owner, moodType: _mood, comment: _comment));

    if (context.mounted) {
      context.showAlert(
          message: "등록 되었어요..",
          positiveCallback: () {
            setState(() {
              _comment = "";
              _controller.text = "";
              _mood = "";
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
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
                      focusNode: _focusNode,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 20),
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
                      for (final imozi in PostModel.MoodTypes)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _mood = imozi;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticInOut,
                            width: _mood == imozi ? 50 : 40,
                            height: _mood == imozi ? 50 : 40,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: _mood == imozi
                                    ? context.colors.secondary
                                    : Colors.white,
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
                            child: Center(
                              child: Text(
                                imozi,
                                style: TextStyle(
                                    fontSize: _mood == imozi ? 30 : 18),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Gaps.v40,
                  // if (!isKeyboardVisible)
                  Center(
                    child: GestureDetector(
                      onTap: () => _onPost(context),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: FancyButton(
                            text: "Post",
                            style: context.buttonTitle,
                            color: Colors.purple.shade100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (ref.watch(postProvider).isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 60,
              color: Colors.black12,
              child: const Center(
                  child: CircularProgressIndicator.adaptive(
                strokeWidth: 3,
                backgroundColor: Colors.red,
              )),
            ),
        ],
      ),
    );
  }
}
