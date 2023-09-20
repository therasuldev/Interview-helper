import 'package:shared_preferences/shared_preferences.dart';

final class NotificationPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void notificationCtrlSet(bool isEnabled) async {
    (await _prefs).setBool('notification', isEnabled);
  }

  /// if it returns true, it means notification settings are enabled.
  Future<bool?> notificationCtrlGet() async {
    final result = (await _prefs).getBool('notification');
    return result;
  }
}
