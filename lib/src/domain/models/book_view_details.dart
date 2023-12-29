import 'book/book.dart';

class BookViewDetails {
  final String? category;
  final int index;
  final Book book;
  final List<Book> otherBooks;
  BookViewDetails({
    this.category,
    required this.index,
    required this.book,
    required this.otherBooks,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'index': index,
      'book': book,
      'otherBooks': otherBooks,
    };
  }
}
