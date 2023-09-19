import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts(String userId) async {
    return _db.collection("posts").where("owner", isEqualTo: userId).get();
  }
}

final postRepo = Provider(
  (ref) => PostRepo(),
);
