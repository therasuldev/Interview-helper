import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Future<String> url;
  
  Book({required this.name, required this.url});

  factory Book.fromJson(Reference ref) {
    return Book(name: ref.name, url: ref.getDownloadURL());
  }
}
