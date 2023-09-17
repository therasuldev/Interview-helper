import 'package:firebase_storage/firebase_storage.dart';
import 'package:interview_prep/src/utils/enum/kpath_event.dart';

abstract class BooksSourceDataSource {
  Future<Set<Map<String, ListResult?>>> getBooksSources(Set<Path> path);
}

class BooksSourceDataSourceImpl implements BooksSourceDataSource {
  @override
  Future<Set<Map<String, ListResult?>>> getBooksSources(Set<Path> path) async {
    final Set<Map<String, ListResult?>> bookSources = {};
    final List<Future<Map<String, ListResult?>>> futures = [];

    for (var i in path) {
      final Map<String, ListResult?> result = {
        i.name: await FirebaseStorage.instance.ref(Path.getPath(i)).listAll(),
      };
      futures.add(Future.value(result));
    }

    final results = await Future.wait(futures);

    for (var i = 0; i < path.length; i++) {
      bookSources.add(results[i]);
    }

    return bookSources;
  }
}
