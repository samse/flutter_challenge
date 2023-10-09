import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'girl_group.dart';

class GirlgroupViewModel extends AsyncNotifier<List<GirlGroup>> {
  @override
  FutureOr<List<GirlGroup>> build() {
    return [
      GirlGroup(name: "Twice", fandomName: "once", imagePath: "twice.jpeg"),
      GirlGroup(name: "NMIX", fandomName: "answer", imagePath: "nmix.jpeg"),
      GirlGroup(
          name: "New Jeans", fandomName: "bunnies", imagePath: "newjeans.jpeg"),
      GirlGroup(name: "Aespa", fandomName: "MY", imagePath: "aespa.jpeg"),
      GirlGroup(
          name: "LESSERAFIM", fandomName: "MY", imagePath: "lesserafim.jpeg"),
    ];
  }
}

final girlgroupProvider =
    AsyncNotifierProvider<GirlgroupViewModel, List<GirlGroup>>(
  () => GirlgroupViewModel(),
);
