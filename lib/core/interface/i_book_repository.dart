import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/app/enum/kpath_event.dart';

abstract class IBookRepository {
  Future<Set<Map<String, ListResult?>>> fetchBooks(Set<Path> path);
  }
