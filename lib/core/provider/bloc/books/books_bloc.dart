import 'package:bloc/bloc.dart';
import 'package:interview_prep/core/app/enum/book.dart';
import 'package:interview_prep/core/app/enum/kpath_event.dart';
import 'package:interview_prep/core/model/book/book.dart';
import 'package:interview_prep/core/model/error/error_model.dart';
import 'package:interview_prep/core/repository/book_repository.dart';

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
    emit(state.copyWith(loading: true));

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
