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
      final data = await bookRepository.fetchBooks(event.payload);
      final books = data.items.map((ref) => Book.fromJson(ref)).toList();

      emit(
        state.copyWith(
          books: books,
          loading: false,
          event: BookEvents.fetchBookSuccess,
          error: null,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          books: [],
          loading: true,
          event: BookEvents.fetchBookError,
          error: ErrorModel(description: exp.toString()),
        ),
      );
    }
  }
}
