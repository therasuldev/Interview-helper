import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationPrefsService {
  Future<void> setNotificationState(bool isEnabled);
  Future<bool?> getNotificationState();
  Future<void> askPermission();
  Future<bool> get isGranted;
}

class NotificationPrefsServiceImpl implements NotificationPrefsService {
  NotificationPrefsServiceImpl() : _notificationPrefs = SharedPreferences.getInstance();
  late final Future<SharedPreferences> _notificationPrefs;

  @override
  Future<void> setNotificationState(bool isEnabled) async {
    (await _notificationPrefs).setBool('notification', isEnabled);
  }

  @override
  Future<bool?> getNotificationState() async {
    final result = (await _notificationPrefs).getBool('notification');
    final granted = await isGranted;
    return (result ?? false) && granted;
  }

  @override
  Future<void> askPermission() async {
    var status = await Permission.notification.request();
    if (status.isGranted || status.isLimited) {
      await setNotificationState(true);
    } else {
      await setNotificationState(false);
    }
  }

  @override
  Future<bool> get isGranted => Permission.notification.isGranted;
}
