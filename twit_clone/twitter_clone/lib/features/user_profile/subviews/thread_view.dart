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

class ThreadsView extends ConsumerStatefulWidget {
  final double headerHeight;
  const ThreadsView({super.key, required this.headerHeight});

  @override
  ConsumerState<ThreadsView> createState() => _ThreadsViewState();
}

class _ThreadsViewState extends ConsumerState<ThreadsView> {
  List<Thread> _threads = [];

  @override
  void initState() {
    fetchThread();
    super.initState();
  }

  void fetchThread() async {
    _threads = await ref.read(threadsProvider.notifier).fetchThreads();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _threads.length == 0
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : buildThreads(context);
  }

  Widget buildThreads(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - widget.headerHeight,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var thread in _threads) ThreadView(thread: thread),
          ],
        ),
      ),
    );
  }
}

class ThreadView extends StatelessWidget {
  final double postCellHeight = 100; //
  final double imgHeight = 220; //
  double get _leftCellHeight {
    double height = 80;
    if (thread.post != null &&
        thread.post!.content != null &&
        thread.post!.content!.isNotEmpty) height = height + 50;
    if (thread.post != null) height = height + postCellHeight;
    if (thread.post != null &&
        thread.post!.images != null &&
        thread.post!.images!.isNotEmpty) height = height + imgHeight;
    return height;
  }

  final Thread thread;
  const ThreadView({super.key, required this.thread});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Avatar(url: thread.user.profileUrl, hasPlusIcon: false),
                  if (thread.post != null)
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
                          thread.user.name,
                          style: context.postTitleText,
                        ),
                        Row(
                          children: [
                            Text(thread.hour),
                            Gaps.h10,
                            GestureDetector(
                                onTap: () {},
                                child: const FaIcon(FontAwesomeIcons.ellipsis))
                          ],
                        )
                      ],
                    ),
                    if (thread.comment!.isNotEmpty)
                      Linkify(
                        options: const LinkifyOptions(
                            humanize: false, defaultToHttps: true),
                        text: thread.comment,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        onOpen: (link) => context.launchURL(link.url),
                        linkStyle: context.linkText,
                      ),
                    if (thread.post != null) buildPost(context, thread.post!),
                    buildBottomIcons(context),
                  ],
                ),
              ),
            )
          ],
        ),
        if (thread.post == null)
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12),
      ],
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
          if (post.images != null && post.images!.length > 0)
            buildImageSlide(context, post.images!, imgHeight),
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

  Widget buildImageSlide(
      BuildContext context, List<String> images, double imgHeight) {
    double cellWidth = MediaQuery.of(context).size.width - 80;
    return Container(
      height: imgHeight,
      width: cellWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var url in images)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: cellWidth - 20,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
