import 'package:flutter/material.dart';

class PrefKeys {
  static const _favoriteKey = 'pref_favorite_key';

  static String favoriteKey(String webtoonId) {
    String key = '${PrefKeys._favoriteKey}_$webtoonId';
    print('favorite key = $key');
    return key;
  }
}

class Res {
  /// Colors
  static const Color keyColor = Color.fromARGB(255, 119, 205, 122);

  /// TextStyles
  static const TextStyle homeStyleTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle detailStyleEpisode = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}
