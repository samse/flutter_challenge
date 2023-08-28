import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';

class NavItem extends StatefulWidget {
  final FaIcon icon;
  final Function onTap;
  String? text;
  NavItem({super.key, required this.icon, required this.onTap, this.text});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon,
          if (widget.text != null)
            Text(
              widget.text!,
              style: context.navText,
            )
        ],
      ),
    );
  }
}
