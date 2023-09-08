import 'package:firebase_storage/firebase_storage.dart';
import 'package:interview_prep/core/app/enum/kpath_event.dart';

abstract class IBookRepository {
  Future<Set<Map<String, ListResult?>>> fetchBooks(Set<Path> path);
}
