import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:flutter_interview_questions/core/model/question/question.dart';

@immutable
class App {
  const App._();
  static build() async {
    WidgetsFlutterBinding.ensureInitialized();
    await path
        .getApplicationDocumentsDirectory()
        .then((directory) async => await Hive.initFlutter(directory.path));

    if (!(Hive.isAdapterRegistered(0))) {
      Hive.registerAdapter(QuestionAdapter());
    }
    await Hive.openBox('questions');
  }
}
