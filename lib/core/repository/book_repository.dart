import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_interview_questions/categories_path.dart';
import 'package:flutter_interview_questions/core/interface/i_book_repository.dart';

class BookRepository extends IBookRepository {
  List<Map<String, ListResult?>> res = [];
  @override
  Future<List<Map<String, ListResult?>>> fetchBooks(List<KPath> path) async {
    for (var p in path) {
      res.add({
        p.name: await FirebaseStorage.instance.ref(KPath.kpath(p)).listAll(),
      });
      //res.add(await FirebaseStorage.instance.ref(KPath.kpath(p)).listAll());
    }
    return res;
  }
}
