
import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  const Book({required this.name, required this.url});

  factory Book.fromStorage(String name, String url) {
    return Book(name: name, url: url);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}