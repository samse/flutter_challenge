import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/common/gaps.dart';
import 'package:twitter_clone/features/authentication/interests_data.dart';

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

  _onTapItem(BuildContext context, int i) {
    setState(() {
      _selectedList[i] = !_selectedList[i];
    });
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
              color: Colors.black38,
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
                  childAspectRatio: 1.8,
                  children: [
                    for (var i = 0; i < _list.length; i++)
                      GestureDetector(
                        onTap: () => _onTapItem(context, i),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                _selectedList[i] ? Colors.blue : Colors.white,
                            border: Border.all(
                                width: 1,
                                color: _selectedList[i]
                                    ? Colors.blue
                                    : Colors.black38),
                          ),
                          child: Text(_list[i]),
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
}
