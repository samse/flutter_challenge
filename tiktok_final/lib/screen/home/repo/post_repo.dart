import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_prj/screen/home/model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TABLE_NAME = "fposts";

  Future<DocumentReference> addPost(PostModel post) async {
    post.createdAt = DateTime.now().millisecondsSinceEpoch;
    return await _db.collection(TABLE_NAME).add(post.toJson());
  }

  Future<void> updateRoom(PostModel post) async {
    return _db.collection(TABLE_NAME).doc(post.postId).set(post.toJson());
  }

  Future<void> remove(PostModel post) async {
    _db.collection(TABLE_NAME).doc(post.postId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPost(String userId) async {
    return _db.collection(TABLE_NAME).where("owner", isEqualTo: userId).get();
  }
}

final postRepo = Provider((ref) => PostRepository());
