part of 'books_bloc.dart';

class BookState {
  final BookEvents? event;
  final List<Book>? books;
  final bool? loading;
  final ErrorModel? error;
  BookState({
    this.event,
    this.loading,
    this.error,
    this.books,
  });

  BookState copyWith({
    BookEvents? event,
    List<Book>? books,
    bool? loading,
    ErrorModel? error,
  }) {
    return BookState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      books: books ?? this.books,
      error: error ?? this.error,
    );
  }

  BookState.unknown([books = const <Book>[]])
      : this(
          event: null,
          books: books,
          loading: true,
          error: null,
        );
}
