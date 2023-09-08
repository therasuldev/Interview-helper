import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class NotificationUtils {
  static Future<void> _start() async {
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

class WorkmanagerUtils {
  static void callbackDispatcher() {
    Workmanager().executeTask((_, __) async {
      await NotificationUtils._start();
      return Future.value(true);
    });
  }
}
