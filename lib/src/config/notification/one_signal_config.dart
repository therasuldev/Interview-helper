import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalConfig {
  OneSignalConfig._();

  static final OneSignalConfig _config = OneSignalConfig._();
  static OneSignalConfig get config => _config;

  Future<void> init() async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize('8e7cb16b-8128-400a-8bfd-60848ca3ef4c');
    await OneSignal.Notifications.requestPermission(true);
  }
}
