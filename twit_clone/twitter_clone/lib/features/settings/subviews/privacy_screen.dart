import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';

class PrivacyScreen extends StatelessWidget {
  static const routeURL = "privacy/:userId";
  static const routeName = "privacy";
  bool isDoingLogout = false;

  PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Row(
            children: [Gaps.h20, Icon(Icons.arrow_back_ios), Text("Back")],
          ),
        ),
        leadingWidth: 100,
        title: Text("Privacy"),
        elevation: 1,
      ),
      body: ListView.separated(
        itemCount: menus.length,
        itemBuilder: (context, index) => makeTile(context, index),
        separatorBuilder: (BuildContext context, int index) {
          return (index == 4) ? context.divider(context) : Gaps.v1;
        },
      ),
    );
  }

  List<Map<String, dynamic>> menus = [
    {"icon": Icons.lock, "text": "Private profile", "toggle": true},
    {
      "icon": Icons.alternate_email,
      "text": "Mentions",
      "submenu": true,
      "subtext": "Everyone"
    },
    {
      "icon": Icons.volume_mute_outlined,
      "text": "Muted",
      "submenu": true,
    },
    {
      "icon": FontAwesomeIcons.eyeSlash,
      "text": "Hidden Words",
      "submenu": true,
    },
    {
      "icon": Icons.help_outline,
      "text": "Prifiles you follow",
      "submenu": true,
    },
    {
      "text": "Our privacy settings",
      "link": true,
      "desc":
          "Some settings, like restrict, apply to both Threads and instagram and can be managed on Instagram.",
    },
    {
      "icon": Icons.block_flipped,
      "text": "Blocked profiles",
      "link": true,
    },
    {
      "icon": Icons.heart_broken,
      "text": "Hide likes",
      "link": true,
    },
  ];

  ListTile makeTile(BuildContext context, int index) {
    Map<String, dynamic> menu = menus[index];
    bool isDividerItem = (index > menus.length == 3);
    return ListTile(
      leading: Icon(menu["icon"],
          color: context.isDarkMode ? Colors.white : Colors.black),
      title: Text(
        menu["text"] ?? "",
        style: context.settingItemText,
      ),
      trailing: makeTrailing(context, menu),
      subtitle: menu["desc"] != null ? Text(menu["desc"]!) : null,
    );
  }

  Widget? makeTrailing(BuildContext context, Map<String, dynamic> menu) {
    bool toggle = menu["toggle"] ?? false;
    bool hasSubmenu = menu["submenu"] ?? false;
    bool hasLink = menu["link"] ?? false;
    print("toggle: $toggle");

    if (toggle) {
      return CupertinoSwitch(
        value: true,
        trackColor: Colors.black,
        activeColor: Colors.black,
        onChanged: (bool value) {},
      );
    } else if (hasSubmenu) {
      String? subText = menu["subtext"];
      return subText != null
          ? SizedBox(
              width: 100,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(subText!),
                Icon(Icons.arrow_forward_ios),
              ]),
            )
          : Icon(Icons.arrow_forward_ios);
    } else if (hasLink) {
      return Icon(Icons.file_upload_outlined);
    }
    return null;
  }
}
