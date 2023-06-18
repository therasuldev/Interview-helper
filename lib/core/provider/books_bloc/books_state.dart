part of 'books_bloc.dart';

class BookState {
  final BookEvents? event;
  List<Map<String, List<Book>>>? library;
  final bool? loading;
  final ErrorModel? error;
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
    ErrorModel? error,
  }) {
    return BookState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      library: library ?? this.library,
      error: error ?? this.error,
    );
  }

  BookState.unknown([library = const <Map<String, List<Book>>>[]])
      : this(
          event: null,
          library: library,
          loading: true,
          error: null,
        );
}
