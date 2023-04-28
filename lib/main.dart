import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_router.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> main() async {
  await path
      .getApplicationDocumentsDirectory()
      .then((directory) async => await Hive.initFlutter(directory.path));

  if (!(Hive.isAdapterRegistered(0))) {
    Hive.registerAdapter(QuestionAdapter());
  }

  await Hive.openBox('questions');
  runApp(const MyApp());
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
