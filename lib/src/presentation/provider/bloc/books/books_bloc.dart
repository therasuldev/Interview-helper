// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import 'package:interview_prep/src/data/datasources/remote/books_source_data_source.dart';
import 'package:interview_prep/src/domain/models/book/book.dart';
import 'package:interview_prep/src/domain/models/error/error_model.dart';
import 'package:interview_prep/src/utils/enum/book.dart';
import 'package:interview_prep/src/utils/enum/kpath_event.dart';

part 'books_event.dart';
part 'books_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BooksSourceDataSourceImpl _bookSource = BooksSourceDataSourceImpl();
  BookBloc() : super(BookState.unknown()) {
    on<BookEvent>((event, emit) {
      switch (event.type) {
        case BookEvents.fetchBookStart:
          return _onFetchBookStart(event);
        default:
      }
    });
  }
  _onFetchBookStart(dynamic event) async {
    emit(state.copyWith(loading: true));

    try {
      final data = await _bookSource.getBooksSources(event.payload);
      List<Map<String, List<Book>>> library = [];

      for (var map in data) {
        List<Book> bookList = [];

        for (var result in map.values.first!.items) {
          String name = result.name;
          String url = await result.getDownloadURL();

          bookList.add(Book.fromStorage(name, url));
        }

        library.add({map.keys.first: bookList});
      }

      emit(
        state.copyWith(
          event: BookEvents.fetchBookSuccess,
          library: library,
          loading: false,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          library: [],
          loading: false,
          event: BookEvents.fetchBookError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }
}
