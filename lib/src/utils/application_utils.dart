import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:interview_prep/firebase_options.dart';
import 'package:interview_prep/gen/assets.gen.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';

base class Application {
  const Application._();

  static start() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await _HiveUtils.initialize();
  }
}

interface class _HiveUtils {
  static Future<void> initialize() async {
    await path
        .getApplicationDocumentsDirectory()
        .then((directory) async => await Hive.initFlutter(directory.path));

    if (!(Hive.isAdapterRegistered(0))) {
      Hive.registerAdapter(QuestionAdapter());
    }
    await Hive.openBox('questions');
    await Hive.openBox('books');
  }
}

 interface class NotificationUtils {
  NotificationUtils._();
  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('app');
    final notificationsPlugin = FlutterLocalNotificationsPlugin();

    final ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (_, __, ___, ____) async {},
    );

    final settings = InitializationSettings(android: android, iOS: ios);
    await notificationsPlugin.initialize(settings);

    await _showNotificationWithDefaultSound(notificationsPlugin);
  }

  static Future<void> _showNotificationWithDefaultSound(
      FlutterLocalNotificationsPlugin notificationsPlugin) async {
    final androidChannel = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      icon: Assets.app.path,
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSChannel = DarwinNotificationDetails();

    final channel =
        NotificationDetails(android: androidChannel, iOS: iOSChannel);
    await notificationsPlugin.show(
      2,
      'Interview Prep App',
      'Get ready for the interview',
      channel,
      payload: 'Default_Sound',
    );
  }
}
