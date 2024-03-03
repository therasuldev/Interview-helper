import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview_helper/src/domain/models/book/book_category.dart';
import 'package:interview_helper/src/domain/models/question/question_category.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../../domain/models/index.dart';

class HiveConfig {
  HiveConfig._();

  static final HiveConfig _config = HiveConfig._();
  static HiveConfig get config => _config;

  Future<void> init() async {
    final dir = await path.getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    // Hive.deleteBoxFromDisk('question-categories');
    // Hive.deleteBoxFromDisk('book-categories');

    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BookCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(QuestionCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(QuestionAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox('questions');
    await Hive.openBox<QuestionCategory>('question-categories');
    await Hive.openBox<BookCategory>('book-categories');
  }
}
