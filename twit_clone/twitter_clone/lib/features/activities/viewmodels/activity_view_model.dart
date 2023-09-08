import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/activity_model.dart';

class ActivityViewModel extends AsyncNotifier<List<Activity>> {
  List<Activity> activities = [];

  @override
  FutureOr<List<Activity>> build() {
    activities = mockDatas();
    return activities;
  }

  Future<List<Activity>> fetchActivities() async {
    const AsyncValue.loading();
    // await Future.delayed(Duration(seconds: 1));
    AsyncValue.data(activities);
    return activities;
  }

  List<Activity> mockDatas() {
    List<Activity> results = [];
    results.add(Activity(
      profileUrl:
          "https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no",
      profileIcon: Image.asset(
        'assets/images/free-icon-at.png',
        width: 20,
        height: 20,
      ),
      name: "samse",
      hour: "4h",
      comment: "Mentioned you",
      subComment:
          "Here's a thread you should follow if you love botany @jane_mobbin",
    ));
    results.add(Activity(
        profileUrl:
            "https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media",
        profileIcon: Image.asset(
          'assets/images/free-icon-undo2.png',
          width: 20,
          height: 20,
        ),
        name: "hangsung",
        hour: "4h",
        comment: "Starting out my gardening club with thr.",
        subComment: "Count me in!"));
    results.add(Activity(
        profileUrl:
            "https://images.squarespace-cdn.com/content/v1/5b843fe8ee17598888a46243/1536588157413-OGX2R907VCZ2ZRGV0B9N/favicon.ico?format=100w",
        profileIcon: Image.asset(
          'assets/images/free-icon-user.png',
          width: 20,
          height: 20,
        ),
        name: "trevornoa",
        hour: "4h",
        comment: "Followed you",
        following: true));
    results.add(Activity(
      profileUrl:
          "https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no",
      profileIcon: Image.asset(
        'assets/images/free-icon-heart.png',
        width: 20,
        height: 20,
      ),
      name: "samse",
      hour: "4h",
      comment: "Definitely broken! ",
    ));
    results.add(Activity(
      name: 'samse',
      hour: "5h",
      profileUrl:
          "https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no",
      profileIcon: Image.asset(
        'assets/images/free-icon-heart.png',
        width: 20,
        height: 20,
      ),
      comment: 'Mentioned',
    ));
    return results;
  }
}

final activityProvider =
    AsyncNotifierProvider<ActivityViewModel, List<Activity>>(
        () => ActivityViewModel());
