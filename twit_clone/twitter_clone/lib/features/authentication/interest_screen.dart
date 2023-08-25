import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/features/authentication/interests_data.dart';

import '../../common/sizes.dart';

class InterestsScreen extends StatefulWidget {
  static const routeURL = "/interests";
  static const routeName = "interests";
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> _list = [];
  List<bool> _selectedList = [];

  void _onTapItem(BuildContext context, int i) {
    setState(() {
      _selectedList[i] = !_selectedList[i];
    });
  }

  void _onNext() {}

  bool _isSelectedItem() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final list = interestItems.entries.map((e) => e.key).toList();

    interestItems.entries.forEach((e) {
      _list.add(e.key);
      _selectedList.add(false);
    });

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: 1,
                    color: Colors.black26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Great work"),
                        buildNextButton(context, MediaQuery.of(context).size)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v64,
              const Center(
                  child: FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
              )),
              Gaps.v32,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "What do you want to see on Twitter?",
                  style: context.pageTitle,
                ),
              ),
              Gaps.v12,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                  style: context.pageSubtitle,
                ),
              ),
              Gaps.v24,
              Container(
                height: 1,
                color: Colors.grey,
                clipBehavior: Clip.none,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 350,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                  children: [
                    for (var i = 0; i < _list.length; i++)
                      GestureDetector(
                        onTap: () => _onTapItem(context, i),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              height: 60,
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: _selectedList[i]
                                    ? Colors.blue
                                    : Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: _selectedList[i]
                                        ? Colors.blue
                                        : Colors.black38),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  _list[i],
                                  style: context.cardText,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              height: 60,
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: Sizes.size20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context, Size size) {
    return Container(
      height: 60,
      width: 200,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _onNext,
        child: Container(
          decoration: BoxDecoration(
            color: _isSelectedItem() ? Colors.black : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(
              "Next",
              style: TextStyle(
                color: _isSelectedItem() ? Colors.white : Colors.grey.shade100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
