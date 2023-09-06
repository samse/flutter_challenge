import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/nav_item.dart';
import 'package:twitter_clone/features/common/avatar.dart';
import 'package:twitter_clone/features/home/models/post.dart';
import 'package:twitter_clone/features/home/subviews/attach_file_screen.dart';
import 'package:twitter_clone/features/home/subviews/posts_screen.dart';
import 'package:twitter_clone/features/user_profile/user_profile_screen.dart';

import '../../common/sizes.dart';
import '../search/models/user.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 4;
  final user = User(
    name: 'samse',
    profileUrl:
        'https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no',
    userId: '1',
  );
  String text = "";
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    _commentController.addListener(() {
      setState(() {
        text = _commentController.text;
      });
      print("$text -> isEmpty ${text.isEmpty}");
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late File? _attachFile = null;
  // File 첨부
  void _onTapFile(BuildContext context) async {
    final XFile? file = await context.pushNamed(AttachFileScreen.routeName);
    if (file != null) {
      print(file.path);
      setState(() {
        _attachFile = File(file.path);
      });
    }
  }

  void _onTapPost(BuildContext context) {
    print("_onTapPost text isEmpty => $text : ${text.isEmpty}");
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 60,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "New thread",
                    style: context.buttonTitle,
                  ),
                  leadingWidth: 100,
                  leading: GestureDetector(
                    onTap: () => context.pop(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Cancel",
                          textAlign: TextAlign.start,
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ),
                  elevation: 0.1,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              Avatar(
                                  profileUrl: user.profileUrl,
                                  size: const Size(40, 40)),
                              const SizedBox(
                                  height: 80, child: VerticalDivider()),
                              Avatar(
                                profileUrl: user.profileUrl,
                                size: const Size(20, 20),
                                blured: true,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "  ${user.name}",
                                    style: context.cardText,
                                  ),
                                  if (text.isNotEmpty)
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _commentController.text = "";
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Icon(
                                            Icons.close,
                                            size: Sizes.size20,
                                          ),
                                        ))
                                ],
                              ),
                              TextField(
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                minLines: 1,
                                controller: _commentController,
                                decoration: const InputDecoration(
                                  hintText: "Start a thread...",
                                  hintStyle: TextStyle(
                                      fontSize: Sizes.size18,
                                      color: Colors.black45),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.white,
                                ),
                              ),
                              _attachFile == null
                                  ? GestureDetector(
                                      onTap: () {
                                        _onTapFile(context);
                                      },
                                      child: Transform.rotate(
                                        angle: 0.5,
                                        child: const Icon(
                                          Icons.attach_file,
                                        ),
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          child: Image.file(
                                            _attachFile!,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _attachFile = null;
                                              });
                                            },
                                            child: Transform.rotate(
                                                angle: 0.5,
                                                child: const Icon(
                                                  Icons.add_circle,
                                                  color: Colors.black38,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Anyone can reply",
                          style: context.normal
                              .copyWith(color: Colors.grey.shade600),
                        ),
                        Text(
                          "Post",
                          style: context.linkText!.copyWith(
                            fontSize: Sizes.size20,
                            color: text.isEmpty
                                ? Colors.blue.shade200
                                : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex == 0 ? false : true,
            child: PostsScreen(context: context),
          ),
          Offstage(
            offstage: _selectedIndex == 1 ? false : true,
            child: const SearchScreen(),
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
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
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
                  onTap: () => _onTapPost(context),
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
      ),
    );
  }
}
