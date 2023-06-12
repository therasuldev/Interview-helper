import 'package:firebase_storage/firebase_storage.dart';

abstract class IBookRepository {
  Future fetchBooks(Reference ref, String root);
}
