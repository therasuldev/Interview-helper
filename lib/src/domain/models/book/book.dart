import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book {
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String url;

  const Book({required this.name, required this.url, required this.imageUrl});

  factory Book.fromJson(Map<String,dynamic> json) {
    return Book(name: json['name'], url: json['url'], imageUrl: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url, 'imageUrl': imageUrl};
  }
}
