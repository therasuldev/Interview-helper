import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/core/app/enum/kpath_event.dart';
import 'package:flutter_interview_questions/core/interface/i_book_repository.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';

class BookRepository extends IBookRepository {
  Set<Map<String, ListResult?>> result = {};
  @override
  Future<Set<Map<String, ListResult?>>> fetchBooks(Set<Path> path) async {
    for (var p in path) {
      result.add({
        p.name: await FirebaseStorage.instance.ref(Path.getPath(p)).listAll(),
      });
    }
    return result;
  }

  @override
  Future<File> getFirstpage(Book book) async {
    final file = await DefaultCacheManager().getSingleFile(await book.url);
    return file;
  }
}
