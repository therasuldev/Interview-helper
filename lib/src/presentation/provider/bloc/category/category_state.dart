part of 'category_bloc.dart';

class CategoryState {
  final CategoryEvents? event;
  final List<QuestionCategory>? questionCategories;
  final List<BookCategory>? bookCategories;
  final List<Question>? questions;
  final List<Book>? books;
  final bool? loading;
  final ExceptionModel? error;

  CategoryState({
    this.event,
    this.loading,
    this.error,
    this.bookCategories,
    this.questionCategories,
    this.questions,
    required this.books,
  });

  CategoryState copyWith({
    CategoryEvents? event,
    List<QuestionCategory>? questionCategories,
    List<BookCategory>? bookCategories,
    List<Question>? questions,
    List<Book>? books,
    bool? loading,
    ExceptionModel? error,
  }) {
    return CategoryState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      questionCategories: questionCategories ?? this.questionCategories,
      bookCategories: bookCategories ?? this.bookCategories,
      books: books ?? this.books,
      questions: questions ?? this.questions,
      error: error ?? this.error,
    );
  }

  factory CategoryState.unknown([
    questionCategories = const <QuestionCategory>[],
    bookCategories = const <BookCategory>[],
    questions = const <Question>[],
    books = const <Book>[],
  ]) {
    return CategoryState(
      questionCategories: questionCategories,
      bookCategories: bookCategories,
      questions: questions,
      books: books,
      loading: false,
      error: null,
      event: null,
    );
  }
}
