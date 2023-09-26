import 'package:flutter/material.dart';

class PostModel {
  static List<String> MoodTypes = [
    "😄",
    "😲",
    "😍",
    "😳",
    "😭",
    "😡",
    "🤪",
    "😬"
  ];

  final String moodType;
  final String comment;
  final String owner;
  String? postId;
  int? createdAt;
  PostModel(
      {required this.owner,
      required this.moodType,
      required this.comment,
      this.createdAt});

  PostModel.fromJson(String id, {required Map<String, dynamic> json})
      : moodType = json["moodType"],
        comment = json["comment"],
        owner = json["owner"],
        postId = id,
        createdAt = json["createdAt"] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "moodType": moodType,
      "comment": comment,
      "owner": owner,
      "postId": postId ?? "",
      "createdAt": createdAt ?? 0,
    };
  }
}
