import 'package:final_prj/app.dart';
import 'package:final_prj/screen/home/subview/mood_list_screen.dart';
import 'package:final_prj/screen/home/subview/write_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/gaps.dart';

class HomeScreen extends StatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late final AnimationController _animController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));
  // late final AnimationController _animController2 =
  //     AnimationController(vsync: this, duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _animController.repeat();
    // _animController2.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _animController.dispose();
    // _animController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade100,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animController.value *
                        2 *
                        3.14159265359, // 2π 라디안을 기준으로 회전
                    child: const FaIcon(
                      FontAwesomeIcons.fireFlameCurved,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  );
                },
              ),
              Gaps.h6,
              Text(
                "MOOD",
                style: context.pageTitle,
              ),
              Gaps.h6,
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animController.value *
                        2 *
                        3.14159265359, // 2π 라디안을 기준으로 회전
                    child: const FaIcon(
                      FontAwesomeIcons.fireFlameCurved,
                      color: Colors.red,
                      size: 20.0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            MoodListScreen(_tabController),
            WritePostScreen(_tabController),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border:
                const Border(top: BorderSide(color: Colors.black, width: 2)),
            color: context.colors.primary,
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                  child: Icon(
                Icons.home_outlined,
                color: Colors.black,
              )),
              Tab(
                  child: Icon(
                Icons.edit,
                color: Colors.black,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
