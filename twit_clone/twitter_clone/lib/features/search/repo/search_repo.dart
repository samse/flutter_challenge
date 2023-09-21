import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class SearchRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<User>> query(String query) async {
    QuerySnapshot querySnapshot = await _db.collection("users").get();
    return querySnapshot.docs
        .where((doc) => ((doc['name'] as String).contains(query)))
        .map((e) => User.fromJson(json: e.data() as Map<String, dynamic>))
        .toList();
  }
}

final searchRepo = Provider(
  (ref) => SearchRepo(),
);
