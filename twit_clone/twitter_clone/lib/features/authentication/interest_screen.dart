import 'dart:math';

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

enum InterestsScreenMode {
  interestSelect, // 관심사 선택 모드
  detailSelect, // 세부관심사 선택 모드
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> _list = [];
  List<bool> _selectedList = [];
  List<String> _selectedInterests = [];
  Map<String, bool> _selectedDetailInterests = {};
  InterestsScreenMode _interestsMode = InterestsScreenMode.interestSelect;

  void _onTapItem(BuildContext context, int i) {
    setState(() {
      _selectedList[i] = !_selectedList[i];
    });
  }

  void _onNext() {
    _selectedInterests = [];
    print("_list length: ${_list.length}");
    for (var i = 0; i < _list.length; i++) {
      if (_selectedList[i] == true) {
        _selectedInterests.add(_list[i]);
      }
    }
    setState(() {
      _interestsMode = InterestsScreenMode.detailSelect;
    });
  }

  bool _isSelectedItem() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    interestItems.entries.forEach((e) {
      _list.add(e.key);
      _selectedList.add(false);
    });

    return Scaffold(
      body: Stack(
        children: [
          buildBottomBar(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v64,
              const Center(
                  child: FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: Sizes.size28,
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
              Container(height: 1, color: Colors.grey, clipBehavior: Clip.none),
              Expanded(
                //height: MediaQuery.of(context).size.height - 300,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: _interestsMode == InterestsScreenMode.interestSelect
                      ? buildInterestsGrid(context)
                      : buildDetailInterestsGrid(context),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildInterestsGrid(BuildContext context) {
    return GridView.count(
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
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _selectedList[i] ? Colors.blue : Colors.white,
                    border: Border.all(
                        width: 1,
                        color: _selectedList[i] ? Colors.blue : Colors.black38),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _list[i],
                      style: context.cardText.copyWith(
                          color:
                              _selectedList[i] ? Colors.white : Colors.black87),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, top: 10),
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
    );
  }

  Widget buildSubItem(
      {required BuildContext context,
      required String interest,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          toggleSelectedDetailInterest("$interest-$text");
        },
        child: Container(
          // key: Key("$interest-$text"),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: getSelectedDetailInterest("$interest-$text")
                    ? Colors.blue
                    : Colors.black38),
            color: getSelectedDetailInterest("$interest-$text")
                ? Colors.blue
                : Colors.white,
          ),
          child: Text(
            text,
            style: context.cardText.copyWith(
                color: getSelectedDetailInterest("$interest-$text")
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildSubItemRow(
      {required BuildContext context,
      required String interest,
      required List<String> subItems,
      required int index}) {
    return Row(
      children: [
        Gaps.h10,
        for (var i = index; i < min(subItems.length, index + 4); i++)
          buildSubItem(context: context, interest: interest, text: subItems[i]),
      ],
    );
  }

  Widget buildSubDetailView(BuildContext context, String interest) {
    List<String> subItems = interestItems[interest]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Gaps.v36,
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            interest,
            style: context.textTheme.headlineLarge,
          ),
        ),
        Gaps.v28,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < subItems.length; i = i + 4)
                  buildSubItemRow(
                      context: context,
                      interest: interest,
                      subItems: subItems,
                      index: i),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDetailInterestsGrid(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var e in _selectedInterests) buildSubDetailView(context, e),
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

  buildBottomBar(BuildContext context) {
    return Align(
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
                  Text("Great work ✌"),
                  buildNextButton(context, MediaQuery.of(context).size)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggleSelectedDetailInterest(String key) {
    setState(() {
      _selectedDetailInterests[key] = !getSelectedDetailInterest(key);
    });
  }

  void setSelectedDetailInterest(String key, bool selected) {
    _selectedDetailInterests[key] = selected;
  }

  bool getSelectedDetailInterest(String key) {
    if (_selectedDetailInterests[key] == null) return false;
    return _selectedDetailInterests[key] ?? false;
  }
}
