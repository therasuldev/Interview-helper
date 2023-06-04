import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String url;
  Book({
    required this.name,
    required this.image,
    required this.url,
  });

  Book.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        image = data['image'],
        url = data['url'];
}
