import 'package:hive/hive.dart';
import 'package:interview_helper/src/domain/models/index.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Question>? questions;
  @HiveField(2)
  final List<Book>? books;

  Category({
    required this.name,
    this.questions,
    this.books,
  });

  void addQuestion(Question question) async {
    if (!questions!.any((q) => q.question == question.question)) {
      questions!.add(question);
    }
  }

  void removeQuestion(Question question) {
    questions!.removeWhere((q) => q.question == question.question);
  }

  void addBook(Book book) async {
    if (!books!.any((b) => b.name == book.name)) {
      books!.add(book);
    }
  }

  void removeBook(Book book) {
    books!.removeWhere((b) => b.name == book.name);
  }
}
