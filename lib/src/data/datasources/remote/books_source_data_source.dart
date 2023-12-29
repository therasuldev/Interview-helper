import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interview_helper/src/utils/index.dart';

typedef BookJsonList = List<Map<String, dynamic>>;

abstract class BooksSourceData {
  Future<Set<Map<String, BookJsonList?>>> getBooksSources();
}

class BooksSourceDataImpl implements BooksSourceData {
  @override
  Future<Set<Map<String, BookJsonList?>>> getBooksSources() async {
    final Set<Map<String, BookJsonList?>> bookSources = {};

    final List<Future<List<DocumentSnapshot>>> futures = BookCollectionPaths.values.map((collectionName) {
      return FirebaseFirestore.instance.collection(collectionName.name).get().then((querySnapshot) {
        return querySnapshot.docs;
      });
    }).toList();

    final List<List<DocumentSnapshot>> results = await Future.wait(futures);

    for (int i = 0; i < BookCollectionPaths.values.length; i++) {
      final String collectionName = BookCollectionPaths.values[i].name;
      final List<DocumentSnapshot> documents = results[i];
      final List<Map<String, dynamic>> bookJsons = [];

      for (var document in documents) {
        bookJsons.add(document.data() as Map<String, dynamic>);
      }
      bookSources.add({collectionName: bookJsons});
    }

    return bookSources;
  }
}
