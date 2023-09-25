import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';

class ConfigViewModel extends ChangeNotifier {
  ConfigModel _config = ConfigModel();

  bool get isDarkMode => _config.isDarkMode;

  void toggleDarkMode() {
    _config.isDarkMode = !_config.isDarkMode;
    notifyListeners();
  }
}

final configProvider = ChangeNotifierProvider((ref) => ConfigViewModel());
