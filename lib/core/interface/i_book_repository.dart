import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/app/enum/kpath_event.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';

abstract class IBookRepository {
  Future<Set<Map<String, ListResult?>>> fetchBooks(Set<Path> path);
  Future<File> getFirstpage(Book book);
}
