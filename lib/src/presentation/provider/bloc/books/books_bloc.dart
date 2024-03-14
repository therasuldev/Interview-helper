// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:interview_helper/src/data/datasources/remote/books_source_data_source.dart';

import '../../../../domain/models/index.dart';

part 'books_event.dart';
part 'books_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc()
      : _bookSource = BooksSourceDataImpl(),
        super(BookState.unknown()) {
    on<BookEvent>((event, emit) {
      switch (event.type) {
        case BookEvents.fetchAllBooksStart:
          return _onFetchAllBooksStart();
        case BookEvents.fetchBooksByCategory:
          return _onfetchBooksByCategory(event);
        default:
      }
    });
  }
  void _onFetchAllBooksStart() async {
    emit(state.copyWith(loading: true));

    try {
      final data = await _bookSource.getAllBooksSources();
      List<Map<String, List<Book>>> library = [];

      for (var map in data) {
        List<Book> bookList = [];

        for (var bookJson in map.values.first!) {
          bookList.add(Book.fromJson(bookJson));
        }

        library.add({map.keys.first: bookList});
      }

      emit(
        state.copyWith(
          event: BookEvents.fetchBooksSuccess,
          library: library,
          loading: false,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          library: [],
          loading: false,
          event: BookEvents.fetchBooksError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  void _onfetchBooksByCategory(BookEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final data = await _bookSource.getBooksByCategory(event.payload);
      List<Book> books = [];

      for (var bookJson in data) {
        books.add(Book.fromJson(bookJson));
      }

      emit(
        state.copyWith(
          event: BookEvents.fetchBooksSuccess,
          loading: false,
          books: books,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          books: [],
          loading: false,
          event: BookEvents.fetchBooksError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  late final BooksSourceDataImpl _bookSource;
}
