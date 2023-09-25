import 'package:final_prj/app.dart';
import 'package:final_prj/common/widget/fancy_button.dart';
import 'package:final_prj/screen/home/subview/mood_list_screen.dart';
import 'package:final_prj/screen/home/subview/write_post_screen.dart';
import 'package:final_prj/screen/home/widget/post_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/gaps.dart';
import 'model/post_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              const FaIcon(
                FontAwesomeIcons.fireFlameCurved,
                color: Colors.red,
                size: 20.0,
              ),
              Gaps.h6,
              Text(
                "MOOD",
                style: context.pageTitle,
              ),
              Gaps.h6,
              const FaIcon(FontAwesomeIcons.fireFlameCurved,
                  color: Colors.red, size: 20.0),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MoodListScreen(),
            WritePostScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 2)),
            color: context.colors.primary,
          ),
          child: const TabBar(
            tabs: [
              Tab(
                  child: Icon(
                Icons.home_outlined,
                color: Colors.black,
              )),
              Tab(child: Icon(Icons.edit, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
