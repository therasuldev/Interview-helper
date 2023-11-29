part of 'books_bloc.dart';

class BookState {
  final BookEvents? event;
  final List<Map<String, List<Book>>>? library;
  final bool? loading;
  final ExceptionModel? error;

  BookState({
    this.event,
    this.loading,
    this.error,
    this.library,
  });

  BookState copyWith({
    BookEvents? event,
    List<Map<String, List<Book>>>? library,
    bool? loading,
    ExceptionModel? error,
  }) {
    return BookState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      library: library ?? this.library,
      error: error ?? this.error,
    );
  }

  factory BookState.unknown([library = const <Map<String, List<Book>>>[]]) {
    return BookState(
      event: null,
      library: library,
      loading: true,
      error: null,
    );
  }
}
