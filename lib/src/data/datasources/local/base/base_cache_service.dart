import 'package:hive/hive.dart';

class CacheService {
  Box get cachedquestions => Hive.box('questions');
}
