part of 'books_bloc.dart';

class BookEvent {
  BookEvents? type;

  BookEvent.fetchBooksStart() {
    type = BookEvents.fetchBookStart;
  }
  BookEvent.fetchBooksSuccess() {
    type = BookEvents.fetchBookSuccess;
  }
  BookEvent.fetchBooksError() {
    type = BookEvents.fetchBookError;
  }
}
