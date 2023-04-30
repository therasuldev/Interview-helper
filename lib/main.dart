import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_build.dart';
import 'package:flutter_interview_questions/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  App.build();
  await initialization();
  runApp(const MyApp());
}

Future initialization() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().router,
    );
  }
}
