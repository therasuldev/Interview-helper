part of 'books_bloc.dart';

class BookState {
  final BookEvents? event;
  final List<Map<String, List<Book>>>? library;
  final bool? loading;
  final ExceptionModel? error;
  final List<Book>? books;

  BookState({
    this.event,
    this.loading,
    this.error,
    this.library,
    this.books,
  });

  BookState copyWith({
    BookEvents? event,
    List<Map<String, List<Book>>>? library,
    bool? loading,
    ExceptionModel? error,
    List<Book>? books,
  }) {
    return BookState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      library: library ?? this.library,
      error: error ?? this.error,
      books: books ?? this.books,
    );
  }

  factory BookState.unknown([library = const <Map<String, List<Book>>>[], books = const <Book>[]]) {
    return BookState(
      event: null,
      library: library,
      books: books,
      loading: true,
      error: null,
    );
  }
}
