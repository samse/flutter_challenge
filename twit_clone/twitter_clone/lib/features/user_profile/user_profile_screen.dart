import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/avatar.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/common/roundbutton.dart';
import 'package:twitter_clone/features/user_profile/subviews/reply_view.dart';
import 'package:twitter_clone/features/user_profile/subviews/thread_view.dart';

const headerHeight = 284.0;

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          scrollBehavior: NoGlow(),
          slivers: [
            SliverAppBar(
              toolbarHeight: 50.0,
              pinned: true,
              floating: true,
              leading: GestureDetector(
                  onTap: () {},
                  child:
                      const Center(child: FaIcon(FontAwesomeIcons.earthAsia))),
              actions: [
                GestureDetector(
                    onTap: () {}, child: FaIcon(FontAwesomeIcons.instagram)),
                Gaps.h10,
                GestureDetector(
                    onTap: () {}, child: FaIcon(FontAwesomeIcons.gripLines)),
                Gaps.h10,
              ],
            ),
            // Text("asdfasf"),
            SliverPersistentHeader(delegate: TabBarDelegate()),
            const SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                children: [
                  ThreadsView(
                    headerHeight: headerHeight,
                  ),
                  RepliesView(
                    headerHeight: headerHeight,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v20,
                    Text(
                      "Samse",
                      style: context.pageTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          "samse_inc",
                          style: context.pageSubtitle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Gaps.h6,
                        Container(
                          child: Text("samse.net"),
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Avatar(
                    url:
                        "https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no",
                    hasPlusIcon: false,
                    size: 60),
              ],
            ),
          ),
          Gaps.v16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Plant enthusiast!",
                style:
                    context.pageSubtitle.copyWith(fontWeight: FontWeight.w500)),
          ),
          Gaps.v16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Stack(
                    children: [
                      Avatar(
                        url:
                            'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media',
                        hasPlusIcon: false,
                        size: 20,
                      ),
                      Positioned(
                        left: 16,
                        child: Avatar(
                            url:
                                'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2Foe6tky7rKsVchNPxJX8eihnC5o22?alt=media',
                            hasPlusIcon: false,
                            size: 20),
                      ),
                    ],
                  ),
                ),
                Text("2 followers",
                    style: context.pageSubtitle
                        .copyWith(color: Colors.grey.shade500)),
              ],
            ),
          ),
          Gaps.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                title: "Edit profile",
                size: Size(MediaQuery.of(context).size.width * 0.45, 40),
              ),
              RoundButton(
                title: "Share profile",
                size: Size(MediaQuery.of(context).size.width * 0.45, 40),
              ),
            ],
          ),
          const TabBar(
            tabs: [
              Tab(
                child: Text("Threads"),
              ),
              Tab(
                child: Text("Replies"),
              ),
            ],
            indicatorColor: Colors.black,
            indicatorWeight: 1,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
