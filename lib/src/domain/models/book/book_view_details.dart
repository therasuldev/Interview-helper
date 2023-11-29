import 'book.dart';

class BookViewDetails {
  final int index;
  final Book book;
  final List<Book> otherBooks;
  BookViewDetails({
    required this.index,
    required this.book,
    required this.otherBooks,
  });

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'book': book,
      'otherBooks': otherBooks,
    };
  }
}
