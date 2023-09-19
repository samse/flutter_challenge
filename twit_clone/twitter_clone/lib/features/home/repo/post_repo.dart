import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts(String userId) async {
    return _db.collection("posts").where("owner", isEqualTo: userId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchImages(
      String userId, String postId) async {
    return _db.collection("posts").doc(postId).collection("images").get();
  }

  Future<DocumentReference> addPost(Post post) async {
    return await _db.collection("post").add(post.toJson());
  }

  Future<void> uploadImage(File file, String fileName) async {
    final fileRef = _storage.ref().child("images/$fileName");
    await fileRef.putFile(file);
  }

  Future<void> onImageUpload() async {}
}

final postRepo = Provider(
  (ref) => PostRepo(),
);
