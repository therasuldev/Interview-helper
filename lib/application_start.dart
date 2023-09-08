import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/firebase_options.dart';
import 'package:interview_prep/utils/hive_utils.dart';

class Application {
  const Application._();

  static start() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await HiveUtils.initialize();
  }
}
