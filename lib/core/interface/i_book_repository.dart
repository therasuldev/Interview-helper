import 'package:flutter_interview_questions/core/app/enum/kpath_event.dart';

abstract class IBookRepository {
  Future fetchBooks(Set<Path> path);
}
