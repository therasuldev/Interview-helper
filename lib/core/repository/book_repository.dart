import 'package:firebase_storage/firebase_storage.dart';
import 'package:interview_prep/core/app/enum/kpath_event.dart';
import 'package:interview_prep/core/interface/i_book_repository.dart';

class BookRepository extends IBookRepository {
  Set<Map<String, ListResult?>> result = {};
  @override
  Future<Set<Map<String, ListResult?>>> fetchBooks(Set<Path> path) async {
    for (var i in path) {
      result.add({
        i.name: await FirebaseStorage.instance.ref(Path.getPath(i)).listAll(),
      });
    }
    return result;
  }
}
