import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/features/activities/activity_tab_view.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

final tabs = [
  "All",
  "Replies",
  "Metions",
  "Venomous",
  "Likes",
  "Rejects",
];

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Activity",
            style: context.pageTitle,
          ),
          centerTitle: false,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 10),
            splashFactory: NoSplash.splashFactory,
            labelPadding: EdgeInsets.all(5),
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            // padding: const EdgeInsets.symmetric(horizontal: 10.0),
            tabs: makeTabs(context),
          ),
        ),
        body: TabBarView(
          children: makeTabBarViews(context),
        ),
      ),
    );
  }

  List<Widget> makeTabs(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < tabs.length; i++) {
      final tab = tabs[i];
      widgets.add(Tab(
        iconMargin: EdgeInsets.zero,
        height: 40,
        icon: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1,
                color: _selectedIndex == i ? Colors.black : Colors.grey),
            color: _selectedIndex == i ? Colors.black : Colors.white,
          ),
          child: Center(
            child: Text(
              tab,
              style: context.buttonTitle.copyWith(
                  color: _selectedIndex == i ? Colors.white : Colors.black),
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  List<Widget> makeTabBarViews(BuildContext context) {
    List<Widget> widgets = [];

    for (var tab in tabs) widgets.add(ActivityTabView(type: tab));

    return widgets;
  }
}
