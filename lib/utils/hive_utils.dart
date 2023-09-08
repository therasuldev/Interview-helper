import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveUtils {
  HiveUtils._();
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
