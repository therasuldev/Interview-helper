import 'package:hive/hive.dart';
import 'package:interview_helper/src/domain/models/index.dart';

part 'book_category.g.dart';

@HiveType(typeId: 0)
class BookCategory {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Book>? books;

  BookCategory({
    required this.name,
    this.books,
  });

  void addBook(Book book) async {
    if (!books!.any((b) => b.name == book.name)) {
      books!.add(book);
    }
  }

  void removeBook(Book book) {
    books!.removeWhere((b) => b.name == book.name);
  }
}
