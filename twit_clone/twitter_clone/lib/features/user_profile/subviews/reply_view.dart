import 'package:flutter/material.dart';

class RepliesView extends StatefulWidget {
  const RepliesView({super.key});

  @override
  State<RepliesView> createState() => _RepliesViewState();
}

class _RepliesViewState extends State<RepliesView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Replies"),
    );
  }
}
