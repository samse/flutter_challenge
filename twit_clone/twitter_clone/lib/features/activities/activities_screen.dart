import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/features/activities/activity_tab_view.dart';

class ActivitiesScreen extends ConsumerStatefulWidget {
  static const routeURL = "/activity";
  static const routeName = "activity";
  const ActivitiesScreen({super.key});

  @override
  ConsumerState<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

final tabs = [
  "All",
  "Replies",
  "Metions",
  "Venomous",
  "Likes",
  "Rejects",
];

class _ActivitiesScreenState extends ConsumerState<ActivitiesScreen> {
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

  Color getTabColor(BuildContext context, int index) {
    return context.isDarkMode(ref)
        ? _selectedIndex == index
            ? Colors.white
            : Colors.black
        : _selectedIndex == index
            ? Colors.black
            : Colors.white;
  }

  Color getTabBorderColor(BuildContext context, int index) {
    return context.isDarkMode(ref)
        ? _selectedIndex == index
            ? Colors.white
            : Colors.black45
        : _selectedIndex == index
            ? Colors.black
            : Colors.grey;
  }

  Color getTabTextColor(BuildContext context, int index) {
    return context.isDarkMode(ref)
        ? _selectedIndex == index
            ? Colors.black
            : Colors.white
        : _selectedIndex == index
            ? Colors.white
            : Colors.black;
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
            border: Border.all(width: 1, color: getTabBorderColor(context, i)),
            color: getTabColor(context, i),
          ),
          child: Center(
            child: Text(
              tab,
              style: context.buttonTitle
                  .copyWith(color: getTabTextColor(context, i)),
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
