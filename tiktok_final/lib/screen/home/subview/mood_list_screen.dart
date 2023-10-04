import 'package:final_prj/app.dart';
import 'package:final_prj/screen/home/viewmodel/post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/gaps.dart';
import '../model/post_model.dart';
import '../widget/post_view.dart';

class MoodListScreen extends ConsumerStatefulWidget {
  final TabController tabController;
  const MoodListScreen(this.tabController, {Key? key}) : super(key: key);

  @override
  ConsumerState<MoodListScreen> createState() => _MoodListScreenState();
}

class _MoodListScreenState extends ConsumerState<MoodListScreen> {
  void _deleteItem(PostModel post) {
    ref.read(postProvider.notifier).removePost(post);
  }

  void _onItemSelected(BuildContext context, PostModel post) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Delete note'),
          message: Text("Are you sure you want to do this?"),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
                _deleteItem(post);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              // 취소 버튼 선택 시 실행되는 코드
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: ref.watch(postListProvider).when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
              backgroundColor: Colors.red,
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Container(
            child: Text(stackTrace.toString()),
          );
        },
        data: (List<PostModel> posts) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onLongPress: () => _onItemSelected(context, post),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Post(
                      postModel: post,
                      style: context.normal,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Gaps.v24,
              itemCount: posts.length);
        },
      ),
      // body: Column(
      //   children: [
      //     Gaps.v40,
      //     ref.watch(postListProvider).when(
      //         data: (posts) {
      //           if (posts.length == 0) {
      //             return GestureDetector(
      //                 onTap: () {
      //                   widget.tabController.animateTo(1);
      //                 },
      //                 child: Center(child: Text("등록된 포스팅이 없어요! 등록해주세요.")));
      //           }
      //           print("Post 개수 : ${posts.length}");
      //           return ListView.separated(
      //               itemBuilder: (context, index) {
      //                 return Container();
      //               },
      //               separatorBuilder: (context, index) => Gaps.v10,
      //               itemCount: posts.length);
      //           // return ListView.separated(
      //           //     itemBuilder: (context, index) {
      //           //       final post = posts[index];
      //           //       print("  ${index + 1}. ${post.moodType} ${post.comment}");
      //           //       // return Post(
      //           //       //   postModel: post,
      //           //       //   style: context.normal,
      //           //       // );
      //           //       return Container(
      //           //         child: Text(post.moodType),
      //           //       );
      //           //     },
      //           //     separatorBuilder: (context, index) => Gaps.v10,
      //           //     itemCount: posts.length);
      //         },
      //         error: (obj, stack) => Container(),
      //         loading: () => CircularProgressIndicator.adaptive())
      //   ],
      // ),
    );
  }
}
