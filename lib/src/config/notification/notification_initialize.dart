
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications{
  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@drawable/app');
    const settings = InitializationSettings(android: android);

    final notificationsPlugin = FlutterLocalNotificationsPlugin();

    await notificationsPlugin.initialize(settings);
    await _showNotificationWithDefaultSound(notificationsPlugin);
  }

  static Future<void> _showNotificationWithDefaultSound(FlutterLocalNotificationsPlugin notificationsPlugin) async {
    const android = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // icon: Assets.app.path,
      importance: Importance.max,
      priority: Priority.high,
    );
    const channel = NotificationDetails(android: android);

    await notificationsPlugin.show(
      2,
      'Interview_Prep_App',
      'Get ready for the interview',
      channel,
      payload: 'Default_Sound',
    );
  }
}