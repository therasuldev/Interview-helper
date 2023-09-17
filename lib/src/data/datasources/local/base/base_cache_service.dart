import 'package:hive/hive.dart';

class CacheService {
  Box get cachedquestions => Hive.box('questions');
  Box get cachedBooks => Hive.box('books');
}
