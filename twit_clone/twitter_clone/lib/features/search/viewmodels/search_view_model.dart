import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class SearchViewModel extends AsyncNotifier<List<User>> {
  List<User> users = [];

  @override
  FutureOr<List<User>> build() {
    users = mockUsers();
    throw users;
  }

  Future<List<User>> queryUsers(String user) async {
    const AsyncValue.loading();
    final res = query(user);
    AsyncValue.data(res);
    return res;
  }

  List<User> query(String user) {
    final Iterable<User> res = users.where((e) => e.name.contains(user));
    if (res == null) [];
    return res.toList()!;
  }

  List<User> mockUsers() {
    List<User> users = [];
    User user1 = User(
      name: 'samse',
      profileUrl:
          'https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no',
      userId: '1',
      subTitle: 'Samse',
      followCount: "26.6K",
      repFollowerProfileUrl:
          'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media',
    );
    User user2 = User(
      name: 'hangsung',
      profileUrl:
          'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media',
      userId: '2',
      subTitle: 'hansung camp',
      followCount: "1.2K",
    );
    User user3 = User(
      name: 'yerin',
      profileUrl:
          'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2Foe6tky7rKsVchNPxJX8eihnC5o22?alt=media',
      userId: '3',
      subTitle: 'Yerin, hanbom highschool.',
      repFollowerProfileUrl:
          'https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no',
      followCount: "12",
    );
    User user4 = User(
      name: 'rjmithun',
      profileUrl:
          'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2Foe6tky7rKsVchNPxJX8eihnC5o22?alt=media',
      userId: '4',
      subTitle: 'Mithun',
      followCount: "20.1K",
    );
    User user5 = User(
        name: 'vicenews',
        profileUrl:
            'https://vice-web-statics-cdn.vice.com/favicons/vice/apple-touch-icon-57x57.png',
        userId: '5',
        subTitle: "VICE News");
    User user6 = User(
      name: 'trevornoah',
      profileUrl:
          'https://images.squarespace-cdn.com/content/v1/5b843fe8ee17598888a46243/1536588157413-OGX2R907VCZ2ZRGV0B9N/favicon.ico?format=100w',
      userId: '6',
      subTitle: "Trevor Noah",
      followCount: "500K",
    );
    User user7 = User(
      name: 'vicenews Ch2',
      profileUrl:
          'https://www.cntraveller.com/verso/static/conde-nast-traveler/assets/favicon.ico',
      userId: '7',
      subTitle: "VICE Sub News",
      followCount: "1.3B",
    );
    users.add(user1);
    users.add(user2);
    users.add(user3);
    users.add(user4);
    users.add(user5);
    users.add(user6);
    users.add(user7);
    return users;
  }
}

final searchProvider = AsyncNotifierProvider<SearchViewModel, List<User>>(
  () => SearchViewModel(),
);
