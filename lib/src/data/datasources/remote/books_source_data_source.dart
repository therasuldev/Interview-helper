import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/enum/enums.dart';

abstract class BooksSourceData {
  Future<Set<Map<String, List<Map<String, dynamic>>?>>> getBooksSources();
}

class BooksSourceDataImpl implements BooksSourceData {
  @override
  Future<Set<Map<String, List<Map<String, dynamic>>?>>> getBooksSources() async {
    final Set<Map<String, List<Map<String, dynamic>>?>> bookSources = {};
    final List<Map<String, dynamic>> bookJsons = [];

    final List<Future<List<DocumentSnapshot>>> futures = Path.values.map((collectionName) {
      return FirebaseFirestore.instance.collection(collectionName.name).get().then((querySnapshot) => querySnapshot.docs);
    }).toList();

    final List<List<DocumentSnapshot>> results = await Future.wait(futures);

    for (int i = 0; i < Path.values.length; i++) {
      final String collectionName = Path.values[i].name;
      final List<DocumentSnapshot> documents = results[i];

      for (var document in documents) {
        bookJsons.add(document.data() as Map<String, dynamic>);
      }
      bookSources.add({collectionName: bookJsons});
    }

    return bookSources;
  }
}
