import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/features/common/avatar.dart';
import 'package:twitter_clone/features/home/viewmodels/posts_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../common/sizes.dart';
import '../../search/models/user.dart';
import '../models/post.dart';

class PostsScreen extends ConsumerStatefulWidget {
  final BuildContext context;
  const PostsScreen({super.key, required this.context});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Home"),
        centerTitle: true,
        title: Transform.rotate(
          angle: 1.5,
          child: const FaIcon(
            FontAwesomeIcons.at,
            size: Sizes.size40,
          ),
        ),
      ),
      body: ref.watch(postListProvider).when(
          data: (data) {
            return buildPosts(context, data);
          },
          error: (obj, stackTrace) {},
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }

  Widget buildPosts(BuildContext context, List<Post> posts) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var post in posts) PostView(post: post),
          ],
        ),
      ),
    );
  }
}

/// 3가지 타입
/// 1. contents와 이미지가 모두 있음
/// 2. contents만 있음
/// 3. 이미지만 있음.
class PostView extends ConsumerStatefulWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  ConsumerState<PostView> createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  final double imgCellHeight = 270;
  double get _leftCellHeight {
    double height = 60;
    if (widget.post.content != null && widget.post.content!.isNotEmpty)
      height = height + 50;
    if (widget.post.image != null) height = height + imgCellHeight;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    print("Real Build Post : ${widget.post.postId}");

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
                  buildAvatar(context, widget.post.profileUrl),
                  const Expanded(
                    child: VerticalDivider(),
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
                    // ref.watch(configProvider.notifier).isDarkMode
                    //     ? Text("DarkMode")
                    //     : Text("LightMode"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.post.userName,
                          style: context.postTitleText,
                        ),
                        Row(
                          children: [
                            Text(widget.post.hours),
                            Gaps.h10,
                            GestureDetector(
                                onTap: () =>
                                    _onTapPostItem(context, widget.post),
                                child: const FaIcon(FontAwesomeIcons.ellipsis))
                          ],
                        )
                      ],
                    ),
                    if (widget.post.content != null &&
                        widget.post.content!.isNotEmpty)
                      Linkify(
                        options: const LinkifyOptions(
                            humanize: false, defaultToHttps: true),
                        text: widget.post.content!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        onOpen: (link) => _launchURL(context, link.url),
                        linkStyle: context.linkText,
                      ),
                    if (widget.post.image != null)
                      buildImageSlide(context, [widget.post.image!]),
                    buildBottomIcons(context),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildUserCircle(context, widget.post.replyUser),
            Gaps.h10,
            if (widget.post.replyUser != null &&
                widget.post.replyUser!.length > 0)
              Text("${widget.post.replyUser!.length} replies"),
            Gaps.h4,
            Text("•"),
            Gaps.h4,
            Text("${widget.post.likeCount} likes")
          ],
        ),
        Divider(),
        // Container(
        //     height: 1,
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.black12),
      ],
    );
  }

  Widget buildAvatar(BuildContext context, String profileUrl) {
    return Avatar(
      profileUrl: profileUrl,
      size: const Size(40, 40),
      hasIcon: true,
    );
  }

  Widget buildImageSlide(BuildContext context, List<String> images) {
    double cellWidth = MediaQuery.of(context).size.width - 80;
    return Container(
      height: imgCellHeight,
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

  Widget buildUserCircle(BuildContext context, List<User>? users) {
    if ((users != null && users!.isNotEmpty)) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            if (users!.length >= 0)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black38, width: 1.0)),
                  child: Image.network(users![0].profileUrl,
                      fit: BoxFit.fitHeight,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      }),
                ),
              ),
            if (users!.length >= 1)
              Positioned(
                left: 10,
                top: 20,
                child: Container(
                  width: 15,
                  height: 15,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black38, width: 1.0)),
                  child: Image.network(users![1].profileUrl,
                      fit: BoxFit.fitHeight,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      }),
                ),
              ),
            if (users!.length >= 2)
              Positioned(
                left: 25,
                top: 35,
                child: Container(
                  width: 10,
                  height: 10,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black38, width: 1.0)),
                  child: Image.network(users![2].profileUrl,
                      fit: BoxFit.fitHeight,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      }),
                ),
              )
          ],
        ),
      );
    } else {
      return Container();
    }
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

  void _launchURL(BuildContext context, String url) async {
    print("Url: $url");
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw "열수 없는 url입니다.";
    }
  }

  void _onTapMenu(int index) {
    print("_onTapMenu - $index");
  }

  void _onTap2ndMenu(int index) {
    print("_onTap2ndMenu - $index");

    final reportReasons = [
      "Why are you reporting this thread?",
      "Your report is anonymous, except if you're reporting an  intelelctual property infringement. If someone is in immediate danger, call the local emergency services - dont't wait.",
      "I just don't like it",
      "It's unlawful content under NetsDG",
      "It's spam",
      "Hate speech or symbole",
      "Nudity or Sexual activity",
      "Implecitly criminal",
      "It's make me angry"
    ];

    if (index == 1) {
      Size size = MediaQuery.of(context).size;
      Navigator.of(context).pop();
      Future.delayed(
          Duration.zero,
          () => showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              showDragHandle: true,
              useSafeArea: true,
              isScrollControlled: true,
              builder: (context) {
                return SizedBox(
                  width: size.width,
                  height: size.height * 0.6,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Why are you reporting this thread?",
                                style: context.pageTitle),
                          );
                        } else if (index == 1) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Text(
                                    "Your report is anonymous, except if you're reporting an  intelelctual property infringement. If someone is in immediate danger, call the local emergency services - dont't wait.",
                                    style: context.pageSubtitle),
                                Gaps.v20,
                                context.divider(context)
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              width: size.width,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    reportReasons[index],
                                    style: context.textTheme.headlineMedium,
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      // separatorBuilder: (context, index) => Gaps.v1,
                      separatorBuilder: (context, index) {
                        return (index < 1) ? Gaps.v1 : context.divider(context);
                      },
                      itemCount: reportReasons.length),
                );
              }));
    }
  }

  void _onTapPostItem(BuildContext context, Post post) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        useSafeArea: true,
        builder: (context) {
          return Container(
            height: 320,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  twoBlockMenu(
                      context: context,
                      height: 140,
                      menus: ['Unfollow', 'Mute'],
                      onTapMenu: (index) => _onTapMenu(index)),
                  Gaps.v16,
                  twoBlockMenu(
                      context: context,
                      height: 140,
                      menus: ['Hide', 'Report'],
                      menuColors: [Colors.black, Colors.red],
                      onTapMenu: (index) => _onTap2ndMenu(index)),
                ],
              ),
            ),
          );
        });
  }
}

Widget twoBlockMenu(
    {required BuildContext context,
    required int height,
    required List<String> menus,
    required Function(int) onTapMenu,
    List<Color>? menuColors}) {
  final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300);
  return Container(
    height: 140,
    width: MediaQuery.of(context).size.width,
    decoration: boxDecoration,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onTapMenu(0), //print("____onTapMenu(0)"),
          child: Text("    ${menus[0]}",
              style: menuColors != null
                  ? context.buttonTitle.copyWith(color: menuColors[0])
                  : context.buttonTitle),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade400.withOpacity(0.5),
        ),
        GestureDetector(
          onTap: () => onTapMenu(1),
          child: Text("    ${menus[1]}",
              style: menuColors != null
                  ? context.buttonTitle.copyWith(color: menuColors[1])
                  : context.buttonTitle),
        ),
      ],
    ),
  );
}
