import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationPrefsService {
  Future<void> setNotificationState(bool isEnabled);
  Future<bool?> getNotificationState();
  Future<void> askPermission();
  Future<bool> get isGranted;
}

final class NotificationPrefsServiceImpl implements NotificationPrefsService {
  NotificationPrefsServiceImpl() : _notificationPrefs = SharedPreferences.getInstance();
  late final Future<SharedPreferences> _notificationPrefs;

  @override
  Future<void> setNotificationState(bool isEnabled) async {
    (await _notificationPrefs).setBool('notification', isEnabled);
  }

  @override
  Future<bool?> getNotificationState() async {
    final result = (await _notificationPrefs).getBool('notification');
    return result;
  }

  @override
  Future<void> askPermission() async {
    await Permission.notification.request();
  }

  @override
  Future<bool> get isGranted => Permission.notification.isGranted;
}
