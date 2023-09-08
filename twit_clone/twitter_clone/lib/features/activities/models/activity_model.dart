import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Activity {
  final String profileUrl;
  final Widget profileIcon;
  final String name;
  final String hour;
  final String comment;
  String? subComment;
  bool? following;
  Activity({
    required this.profileUrl,
    required this.profileIcon,
    required this.name,
    required this.hour,
    required this.comment,
    this.subComment,
    this.following,
  });
}
