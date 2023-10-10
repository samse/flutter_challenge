import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'girl_group.dart';

class GirlgroupViewModel extends AsyncNotifier<List<GirlGroup>> {
  @override
  FutureOr<List<GirlGroup>> build() {
    return [
      GirlGroup(
          name: "Twice",
          fandomName: "once",
          imagePath: "twice.jpeg",
          color: Colors.cyan),
      GirlGroup(
          name: "NMIX",
          fandomName: "answer",
          imagePath: "nmix.jpeg",
          color: Colors.amber),
      GirlGroup(
          name: "New Jeans",
          fandomName: "bunnies",
          imagePath: "newjeans.jpeg",
          color: Colors.deepOrangeAccent),
      GirlGroup(
          name: "Aespa",
          fandomName: "MY",
          imagePath: "aespa.jpeg",
          color: Colors.blueAccent),
      GirlGroup(
          name: "LESSERAFIM",
          fandomName: "MY",
          imagePath: "lesserafim.jpeg",
          color: Colors.purpleAccent),
    ];
  }
}

final girlgroupProvider =
    AsyncNotifierProvider<GirlgroupViewModel, List<GirlGroup>>(
  () => GirlgroupViewModel(),
);
