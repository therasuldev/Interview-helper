import 'package:hive/hive.dart';

class CacheService {
  Box get questions => Hive.box('questions');
}
