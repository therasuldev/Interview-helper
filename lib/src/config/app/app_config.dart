import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_helper/src/config/firebase_options.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig _config = AppConfig._();
  static AppConfig get config => _config;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
