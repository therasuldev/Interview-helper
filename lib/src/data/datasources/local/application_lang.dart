import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ApplicationLang {
  Future<String> getAppLang();
  Future<void> setAppLang(String lang);
}

class ApplicationLangImpl implements ApplicationLang {
  ApplicationLangImpl() : _applicationLangPrefs = SharedPreferences.getInstance();
  late final Future<SharedPreferences> _applicationLangPrefs;

  @override
  Future<String> getAppLang() async {
    final lang = (await _applicationLangPrefs).getString('lang');
    return lang ?? 'tr';
  }

  @override
  Future<void> setAppLang(String lang) async {
    (await _applicationLangPrefs).setString('lang', lang);
  }
}
