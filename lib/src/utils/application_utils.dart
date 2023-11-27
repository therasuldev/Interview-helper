import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:prepare_for_interview/firebase_options.dart';

import '../domain/models/models.dart';


class Application {
  static Future<void> start() async {
    //! FIREBASE INITIALIZE

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //! HIVE INITIALIZE

    await path.getApplicationDocumentsDirectory().then((directory) async {
      await Hive.initFlutter(directory.path);
    });

    if (!(Hive.isAdapterRegistered(0))) {
      Hive.registerAdapter(QuestionAdapter());
    }
    await Hive.openBox('questions');
    await Hive.openBox('books');
    
  }
}

class NotificationUtils {
  //NotificationUtils._();
  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@drawable/app');
    const settings = InitializationSettings(android: android);

    final notificationsPlugin = FlutterLocalNotificationsPlugin();

    await notificationsPlugin.initialize(settings);
    await _showNotificationWithDefaultSound(notificationsPlugin);
  }

  Future<void> _showNotificationWithDefaultSound(FlutterLocalNotificationsPlugin notificationsPlugin) async {
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
