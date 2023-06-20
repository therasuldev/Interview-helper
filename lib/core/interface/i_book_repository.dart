import 'package:flutter_interview_questions/categories_path.dart';

abstract class IBookRepository {
  Future fetchBooks(List<KPath> path);
}
