import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../repo/search_repo.dart';

class SearchViewModel extends AsyncNotifier<List<User>> {
  late SearchRepo _searchRepo;
  List<User> users = [];

  @override
  FutureOr<List<User>> build() {
    _searchRepo = ref.read(searchRepo);
    throw List.empty();
  }

  Future<List<User>> queryUsers(String user) async {
    const AsyncValue.loading();
    final result = await _searchRepo.query(user);
    AsyncValue.data(result);
    return result;
  }
}

final searchProvider = AsyncNotifierProvider<SearchViewModel, List<User>>(
  () => SearchViewModel(),
);
