import 'package:bloc/bloc.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/core/model/error/error_model.dart';
import 'package:flutter_interview_questions/core/repository/book_repository.dart';

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
      final data = await bookRepository.downloadBook(event.payload);

      final questions = data.map((question) {
        return Book.fromJson(question);
      }).toList();

      emit(
        state.copyWith(
          books: questions,
          loading: false,
          event: BookEvents.fetchBookSuccess,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          books: [],
          loading: true,
          event: BookEvents.fetchBookError,
          error: ErrorModel(description: e.toString()),
        ),
      );
    }
  }
}
