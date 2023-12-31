import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../../domain/models/index.dart';

class HiveConfig {
  HiveConfig._();

  static final HiveConfig _config = HiveConfig._();
  static HiveConfig get config => _config;

  Future<void> init() async {
    final dir = await path.getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);

    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(QuestionAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox('questions');
  }
}
