import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AppIntroductionPrefs {
  Future<bool> getIntroducedState();
  Future<void> setIntroducedState(bool value);
}

class AppIntroductionPrefsImpl implements AppIntroductionPrefs {
  AppIntroductionPrefsImpl() : _applicationPrefs = SharedPreferences.getInstance();
  late final Future<SharedPreferences> _applicationPrefs;

  @override
  Future<bool> getIntroducedState() async {
    final app = (await _applicationPrefs).getBool('introduced');
    return app ?? false;
  }

  /// application opens first time
  @override
  Future<void> setIntroducedState(bool value) async {
    (await _applicationPrefs).setBool('introduced', value);
  }
}
