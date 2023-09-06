import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/notifications_utils.dart';
import 'package:flutter_interview_questions/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:workmanager/workmanager.dart';

@immutable
class Application {
  const Application._();

  static start() async {
    WidgetsFlutterBinding.ensureInitialized();

    //Background local notifications service
    await Workmanager().initialize(WorkmanagerUtils.callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      '2',
      'Interview Questions App',
      frequency: const Duration(days: 5),
    );

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await HiveUtils.initialize();
  }
}

class HiveUtils {
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
