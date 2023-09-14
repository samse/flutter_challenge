import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/features/settings/subviews/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeURL = "/settings";
  static const routeName = "settings";

  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDoingLogout = false;

  void _doLogout() {
    context.pop();
    setState(() {
      isDoingLogout = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isDoingLogout = false;
        });
      });
    });
  }

  void _onTap(BuildContext context, int index) {
    print("_onTap: $index");
    if (index == 2) {
      // Privacy
      // context.pushNamed(PrivacyScreen.routeName);
      // context.pushNamed(PrivacyScreen.routeName, extra: {"userId": '1234'});
      context.pushNamed(PrivacyScreen.routeName,
          pathParameters: {"userId": '1234'});
      // Navigator.of(context)
      //     .pushNamed(PrivacyScreen.routeName, arguments: {"userId": "21"});
    } else if (index == 6) {
      print("kIsWeb : $kIsWeb");
      if (kIsWeb || Platform.isAndroid) {
        final alert = AlertDialog(
          title: const Text("로그아웃"),
          content: const Text("로그아웃 하시겠습니까?"),
          actions: [
            GestureDetector(
                onTap: () => context.pop(), child: const Text("아니오")),
            GestureDetector(onTap: _doLogout, child: const Text("예")),
          ],
        );
        showDialog(context: context, builder: (context) => alert);
      } else {
        final alert = CupertinoAlertDialog(
          title: const Text("로그아웃"),
          content: const Text("로그아웃 하시겠습니까?"),
          actions: [
            GestureDetector(
                onTap: () => context.pop(),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("아니오"),
                ))),
            GestureDetector(
                onTap: _doLogout,
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("예"),
                ))),
          ],
        );
        showDialog(context: context, builder: (context) => alert);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Row(
            children: [Gaps.h20, Icon(Icons.arrow_back_ios), Text("Back")],
          ),
        ),
        leadingWidth: 100,
        title: Text("Settings"),
        elevation: 1,
      ),
      body: ListView.separated(
        itemCount: menus.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => _onTap(context, index),
            child: makeTile(context, index)),
        separatorBuilder: (BuildContext context, int index) {
          return (index > menus.length - 3)
              ? context.divider(context)
              : Gaps.v1;
        },
      ),
    );
  }

  List<Map<String, dynamic>> menus = [
    {"icon": Icons.person_add, "text": "Follow and invite friends"},
    {"icon": Icons.notifications, "text": "Notifications"},
    {"icon": Icons.lock, "text": "Privacy"},
    {"icon": Icons.account_circle_outlined, "text": "Account"},
    {"icon": Icons.help_outline, "text": "Help"},
    {"icon": Icons.info_outline, "text": "About"},
    {"text": "Log out"}
  ];

  ListTile makeTile(BuildContext context, int index) {
    Map<String, dynamic> menu = menus[index];
    bool isLastItem = (index > menus.length - 2);
    return ListTile(
      leading: Icon(menu["icon"],
          color: context.isDarkMode ? Colors.white : Colors.black),
      title: Text(
        menu["text"],
        style: isLastItem
            ? context.settingItemText.copyWith(color: Colors.blue)
            : context.settingItemText,
      ),
      trailing:
          (isDoingLogout && index == 6) ? CupertinoActivityIndicator() : null,
    );
  }
}
