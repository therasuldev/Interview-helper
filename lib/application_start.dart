import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/firebase_options.dart';
import 'package:interview_prep/utils/hive_utils.dart';
import 'package:interview_prep/utils/work_manager_utils.dart';
import 'package:workmanager/workmanager.dart';

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
