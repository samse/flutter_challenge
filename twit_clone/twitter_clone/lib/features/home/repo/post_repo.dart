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

  // Future<QuerySnapshot<Map<String, dynamic>>> fetchImages(
  //     String userId, String postId) async {
  //   return _db.collection("posts").doc(postId).collection("images").get();
  // }

  Future<DocumentReference> addPost(Post post) async {
    return await _db.collection("posts").add(post.toJson());
  }

  Future<void> updatePost(Post post) async {
    print("updatePost post -> ${post.toString()}");
    await _db.collection("posts").doc(post.postId).set(post.toJson());
  }

  Future<String?> uploadImage(File file, String fileName) async {
    print("uploadImage fileName:$fileName, file:$file ");
    final fileRef = _storage.ref().child("images/$fileName");
    print("uploadImage fileRef: $fileRef");
    try {
      await fileRef.putFile(file);
      final imageUrl = await fileRef.getDownloadURL();
      print("image url: $imageUrl");
      return imageUrl;
    } on Exception catch (_, e) {
      print("Upload Failed : ${e.toString()}");
    }
    return null;
  }

  Future<void> onImageUpload() async {}
}

final postRepo = Provider(
  (ref) => PostRepo(),
);
