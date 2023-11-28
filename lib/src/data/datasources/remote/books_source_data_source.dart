import 'package:firebase_storage/firebase_storage.dart';

import '../../../utils/enum/enums.dart';

abstract class BooksSourceData {
  Future<Set<Map<String, ListResult?>>> getBooksSources(Set<Path> path);
}

class BooksSourceDataImpl implements BooksSourceData {
  @override
  Future<Set<Map<String, ListResult?>>> getBooksSources(Set<Path> path) async {
    final Set<Map<String, ListResult?>> bookSources = {};
    final List<Future<Map<String, ListResult?>>> futures = [];

    for (final p in path) {
      futures.add(
        FirebaseStorage.instance.ref(p.getPath()).listAll().then(
              (listResult) => {p.name: listResult},
            ),
      );
    }

    final results = await Future.wait(futures);

    for (var i = 0; i < path.length; i++) {
      bookSources.add(results[i]);
    }

    return bookSources;
  }
}
