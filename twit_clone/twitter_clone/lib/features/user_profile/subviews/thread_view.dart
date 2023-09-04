import 'package:flutter/material.dart';

class ThreadsView extends StatefulWidget {
  const ThreadsView({super.key});

  @override
  State<ThreadsView> createState() => _ThreadsViewState();
}

class _ThreadsViewState extends State<ThreadsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Threads"),
    );
  }
}
