import 'package:hive/hive.dart';

class CacheService {
  Box get questions => Hive.box('questions');
  Box get downloadedBooks => Hive.box('books');
}
