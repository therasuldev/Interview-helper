import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:interview_helper/src/data/datasources/local/notification_prefs_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalConfig {
  OneSignalConfig._();

  static final OneSignalConfig _config = OneSignalConfig._();
  static OneSignalConfig get config => _config;

  Future<void> init() async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(dotenv.env['ONE_SIGNAL_APP_ID']!);

    await OneSignal.Notifications.requestPermission(true).then((isEnabled) async {
      await NotificationPrefsServiceImpl().setNotificationState(isEnabled);
    });
  }
}
