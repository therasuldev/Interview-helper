import 'package:bloc/bloc.dart';
import 'package:flutter_interview_questions/core/app/enum/book.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/core/model/error/error_model.dart';
import 'package:flutter_interview_questions/core/repository/book_repository.dart';

import '../../app/enum/kpath_event.dart';

part 'books_event.dart';
part 'books_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository = BookRepository();
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
    emit(state.copyWith(event: event.type, loading: true));

    try {
      final data = await bookRepository.fetchBooks(event.payload);
      List<Map<String, List<Book>>> library = [];

      for (var map in data) {
        List<Book> bookList = [];
        map.forEach((_, value) {
          for (var result in value!.items) {
            bookList.add(Book.fromJson(result));
          }
        });

        library.add({map.keys.first: bookList});
      }

      emit(
        state.copyWith(
          library: library,
          loading: false,
          event: BookEvents.fetchBookSuccess,
          error: null,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          library: [],
          loading: false,
          event: BookEvents.fetchBookError,
          error: ErrorModel(description: exp.toString()),
        ),
      );
    }
  }
}
