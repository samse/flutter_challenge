import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/common/nav_item.dart';
import 'package:twitter_clone/features/home/subviews/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex == 0 ? false : true,
            child: PostsScreen(context: context),
          ),
          Offstage(
            offstage: _selectedIndex == 1 ? false : true,
            child: Center(child: Container(child: Text("2"))),
          ),
          Offstage(
            offstage: _selectedIndex == 2 ? false : true,
            child: Center(child: Container(child: Text("3"))),
          ),
          Offstage(
            offstage: _selectedIndex == 3 ? false : true,
            child: Center(child: Container(child: Text("4"))),
          ),
          Offstage(
            offstage: _selectedIndex == 4 ? false : true,
            child: Center(child: Container(child: Text("5"))),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  color: _selectedIndex == 0 ? Colors.black : Colors.black26,
                ),
                onTap: () => _onTap(0),
              ),
              NavItem(
                icon: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: _selectedIndex == 1 ? Colors.black : Colors.black26,
                ),
                onTap: () => _onTap(1),
              ),
              NavItem(
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: _selectedIndex == 2 ? Colors.black : Colors.black26,
                ),
                onTap: () => _onTap(2),
              ),
              NavItem(
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: _selectedIndex == 3 ? Colors.black : Colors.black26,
                ),
                onTap: () => _onTap(3),
              ),
              NavItem(
                icon: FaIcon(
                  FontAwesomeIcons.user,
                  color: _selectedIndex == 4 ? Colors.black : Colors.black26,
                ),
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
