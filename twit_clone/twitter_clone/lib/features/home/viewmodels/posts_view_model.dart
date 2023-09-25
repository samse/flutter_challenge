import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/authentication/repo/authentication_repo.dart';

import '../../search/models/user.dart';
import '../models/post.dart';
import '../repo/post_repo.dart';

class PostsViewModel extends AsyncNotifier<List<Post>> {
  late final PostRepo _postRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<List<Post>> build() {
    _postRepo = ref.read(postRepo);
    _authRepo = ref.read(authRepo);

    return List.empty();
  }

  Future<String> sendPost(Post post) async {
    final docRef = await _postRepo.addPost(post);
    return docRef.id;
  }

  Future<void> updatePost(Post post) async {
    await _postRepo.updatePost(post);
  }

  Future<String?> uploadImage(File file, String fileName) async {
    return await _postRepo.uploadImage(file, fileName);
  }
}

final postProvider = AsyncNotifierProvider<PostsViewModel, List<Post>>(
  () => PostsViewModel(),
);

/// 포스트가 올라가면 바로 반영되도록 함.
final postListProvider = StreamProvider.autoDispose<List<Post>>((ref) {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final userId = ref.read(authRepo).user!.uid;
  Stream<QuerySnapshot> stream =
      _db.collection("posts").where("owner", isEqualTo: userId).snapshots();
  return stream.map((snapShot) {
    final posts = snapShot.docs.map((doc) =>
        Post.fromJson(doc.id, json: doc.data() as Map<String, dynamic>));
    for (final post in posts) {
      print("${post.userName} ${post.postId}");
    }
    return posts.toList();
  });
});
