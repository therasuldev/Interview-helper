import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:prepare_for_interview/firebase_options.dart';

import '../../domain/models/models.dart';

class Application {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

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
