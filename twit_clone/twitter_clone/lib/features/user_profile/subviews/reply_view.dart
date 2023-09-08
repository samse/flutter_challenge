import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/avatar.dart';
import 'package:twitter_clone/features/user_profile/models/thread.dart';
import 'package:twitter_clone/features/user_profile/viewmodels/thread_view_model.dart';

import '../../../common/gaps.dart';
import '../../home/models/post.dart';

class RepliesView extends ConsumerStatefulWidget {
  final double headerHeight;
  const RepliesView({super.key, required this.headerHeight});

  @override
  ConsumerState<RepliesView> createState() => _RepliesViewState();
}

class _RepliesViewState extends ConsumerState<RepliesView> {
  List<Thread> _replies = [];

  @override
  void initState() {
    fetchThread();
    super.initState();
  }

  void fetchThread() async {
    _replies = await ref.read(threadsProvider.notifier).fetchThreads();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _replies.length == 0
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : buildReplies(context);
  }

  Widget buildReplies(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - widget.headerHeight,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var reply in _replies) ReplyView(reply: reply),
          ],
        ),
      ),
    );
  }
}

class ReplyView extends StatelessWidget {
  final double postCellHeight = 100;
  double get _leftCellHeight {
    double height = 80;
    if (reply.post != null &&
        reply.post!.content != null &&
        reply.post!.content!.isNotEmpty) height = height + 50;
    if (reply.post != null) height = height + postCellHeight;
    return height;
  }

  final Thread reply;
  const ReplyView({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // 드래그 방향에 따라 탭 전환
        if (details.primaryVelocity! > 0) {
          // 오른쪽으로 드래그
          DefaultTabController.of(context)!.animateTo(0);
        } else {
          // 왼쪽으로 드래그
          DefaultTabController.of(context)!.animateTo(1);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: _leftCellHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //buildAvatar(context, widget.post.profileUrl),
                    Avatar(url: reply.user.profileUrl, hasPlusIcon: false),
                    if (reply.post != null)
                      Expanded(
                        child: Container(
                          width: 1,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            reply.user.name,
                            style: context.postTitleText,
                          ),
                          Row(
                            children: [
                              Text(reply.hour),
                              Gaps.h10,
                              GestureDetector(
                                  onTap: () {},
                                  child:
                                      const FaIcon(FontAwesomeIcons.ellipsis))
                            ],
                          )
                        ],
                      ),
                      if (reply.comment!.isNotEmpty)
                        Linkify(
                          options: const LinkifyOptions(
                              humanize: false, defaultToHttps: true),
                          text: reply.comment,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          onOpen: (link) => context.launchURL(link.url),
                          linkStyle: context.linkText,
                        ),
                      if (reply.post != null) buildPost(context, reply.post!),
                      buildBottomIcons(context),
                    ],
                  ),
                ),
              )
            ],
          ),
          if (reply.post == null)
            Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black12),
        ],
      ),
    );
  }

  Widget buildPost(BuildContext context, Post post) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                url: post.profileUrl,
                hasPlusIcon: false,
                size: 20,
              ),
              Text(post.owner),
              Gaps.h4,
              Icon(Icons.check_circle, color: Colors.blue, size: 20.0),
            ],
          ),
          if (post.content != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(post.content!),
            ),
          Gaps.v14,
          if (post.replyUser != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("${post.replyUser!.length} replies"),
            ),
          Gaps.v10,
        ],
      ),
    );
  }

  Widget buildBottomIcons(BuildContext context) {
    return Container(
      height: 40,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(FontAwesomeIcons.heart),
          Gaps.h14,
          FaIcon(FontAwesomeIcons.comment),
          Gaps.h14,
          FaIcon(FontAwesomeIcons.penToSquare),
          Gaps.h14,
          FaIcon(FontAwesomeIcons.paperPlane),
        ],
      ),
    );
  }
}
