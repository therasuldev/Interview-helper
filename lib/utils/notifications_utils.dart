import 'package:interview_prep/gen/assets.gen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  NotificationUtils._();
  static Future<void> initialize() async {
    final notificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('background');

    final ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      //TODO: fix later
      onDidReceiveLocalNotification: (_, __, ___, ____) async {},
    );

    final settings = InitializationSettings(android: android, iOS: ios);
    await notificationsPlugin.initialize(settings);

    await _showNotificationWithDefaultSound(notificationsPlugin);
  }

  static Future<void> _showNotificationWithDefaultSound(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    final androidChannel = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      icon: Assets.splash.path,
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSChannel = DarwinNotificationDetails();

    final channel =
        NotificationDetails(android: androidChannel, iOS: iOSChannel);
    //TODO: fix later
    await notificationsPlugin.show(
      2,
      'Interview Questions App',
      'Get ready for the interview',
      channel,
      payload: 'Default_Sound',
    );
  }
}
