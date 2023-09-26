import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_prj/screen/home/repo/post_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/repo/authentication_repo.dart';
import '../model/post_model.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final PostRepository _postRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _postRepo = ref.read(postRepo);
    _authRepo = ref.read(authRepo);
  }

  Future<void> addPost(PostModel post) async {
    print("addPost ${post}");
    await AsyncValue.guard(() async {
      final docRef = await _postRepo.addPost(post);
      print("  docRef: ${docRef.id}");
      post.postId = docRef.id;
      await _postRepo.updateRoom(post);
    });
  }
}

final postProvider = AsyncNotifierProvider(() => PostViewModel());

final postListProvider = StreamProvider.autoDispose<List<PostModel>>((ref) {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final userId = ref.read(authRepo).user!.uid;
  Stream<QuerySnapshot> stream = _db
      .collection("fposts")
      .orderBy("createdAt", descending: true)
      .where("owner", isEqualTo: userId)
      .snapshots();
  return stream.map((snapShot) {
    final posts = snapShot.docs.map((doc) =>
        PostModel.fromJson(doc.id, json: doc.data() as Map<String, dynamic>));
    for (final post in posts) {
      print("${post.postId} ${post.moodType}");
    }
    return posts.toList();
  });
});
