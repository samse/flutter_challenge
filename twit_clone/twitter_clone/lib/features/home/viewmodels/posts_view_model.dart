import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../search/models/user.dart';
import '../models/post.dart';

class PostsViewModel extends AsyncNotifier<List<Post>> {
  @override
  FutureOr<List<Post>> build() {
    return List.empty();
  }

  Future<List<Post>> fetchPosts() async {
    print("loading");
    const AsyncValue.loading();
    print("delay");
    await Future.delayed(const Duration(milliseconds: 1000));
    print("completed delay");
    final res = mockDatas();
    AsyncValue.data(res);
    return res;
  }
}

List<Post> mockDatas() {
  List<Post> posts = [];
  User user1 = User(
    name: 'samse',
    profileUrl:
        'https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no',
    userId: '1',
  );
  User user2 = User(
    name: 'hangsung',
    profileUrl:
        'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media',
    userId: '2',
  );
  User user3 = User(
    name: 'yerin',
    profileUrl:
        'https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2Foe6tky7rKsVchNPxJX8eihnC5o22?alt=media',
    userId: '3',
  );
  posts.add(Post(
    // 이미지 여러장인 컨텐츠
    owner: '삼스',
    profileUrl:
        "https://lh3.googleusercontent.com/a/AAcHTtcjRUI1oTPhL2dX2CJvgex4wnfnKzJtUMXNZTo8tDnjgOFF=s576-c-no",
    liked: true,
    blueMarked: true,
    likeCount: 100,
    hours: "2h",
    content:
        "사진 몇장을 올립니다. 이 사진들은 아래 주소로 접근이 가능합니다!!! \nhttps://source.unsplash.com/random?sig=100",
    replyUser: [user1, user2, user3],
    images: [
      "https://source.unsplash.com/random?sig=100",
      "https://source.unsplash.com/random?sig=101",
      "https://source.unsplash.com/random?sig=102",
    ],
  ));
  posts.add(Post(
    // 텍스트만 있는 컨텐츠
    owner: "Jinwha",
    profileUrl:
        "https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media",
    liked: false,
    blueMarked: false,
    likeCount: 10,
    hours: "3h 10m",
    content: "하지만 챌린지도 일주일간 계속되는데...",
    replyUser: [user3, user2, user1],
  ));
  posts.add(Post(
      // 이미지 여러장인 컨텐츠
      owner: '니꼬',
      profileUrl:
          "https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2Foe6tky7rKsVchNPxJX8eihnC5o22?alt=media",
      liked: true,
      blueMarked: true,
      likeCount: 10000,
      hours: "6d",
      replyUser: [
        user2,
        user1,
        user3
      ],
      images: [
        "https://source.unsplash.com/random?sig=103",
        "https://source.unsplash.com/random?sig=104",
        "https://source.unsplash.com/random?sig=105",
        "https://source.unsplash.com/random?sig=106",
        "https://source.unsplash.com/random?sig=107",
        "https://source.unsplash.com/random?sig=108",
        "https://source.unsplash.com/random?sig=109",
      ]));

  posts.add(Post(
    // 이미지 여러장인 컨텐츠
    owner: 'Jinwha',
    profileUrl:
        "https://firebasestorage.googleapis.com/v0/b/nto-talk.appspot.com/o/avatars%2FZ0ORTzflj6f69BjO1OVO1Tx1xnf2?alt=media",
    liked: true,
    blueMarked: true,
    likeCount: 100,
    hours: "2h",
    content:
        "답변 감사합니다! 저도 말씀하신 방법으로 설치해보았는데 터미널 자체에서 멈췄었습니다.제 맥이 구형이라 그런건지, 어디선가 flutter 설치가 꼬였는지 잘 모르겠네요 ㅎㅎSend a message in flutter pub get 오류",
    replyUser: [user1, user2, user3],
    images: [
      "https://source.unsplash.com/random?sig=110",
      "https://source.unsplash.com/random?sig=111",
      "https://source.unsplash.com/random?sig=112",
      "https://source.unsplash.com/random?sig=113",
      "https://source.unsplash.com/random?sig=114",
      "https://source.unsplash.com/random?sig=115",
      "https://source.unsplash.com/random?sig=116",
      "https://source.unsplash.com/random?sig=117",
      "https://source.unsplash.com/random?sig=118",
      "https://source.unsplash.com/random?sig=119",
      "https://source.unsplash.com/random?sig=120",
    ],
  ));

  return posts;
}

final postsProvider = AsyncNotifierProvider<PostsViewModel, List<Post>>(
  () => PostsViewModel(),
);
