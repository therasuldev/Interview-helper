import 'package:firebase_storage/firebase_storage.dart';

abstract class IBookRepository {
  Future downloadBook(int index, Reference ref);
}
