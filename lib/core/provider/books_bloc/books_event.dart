part of 'books_bloc.dart';

class BookEvent {
  BookEvents? type;
  dynamic payload;

  BookEvent.fetchBooksStart(List<KPath> path) {
    type = BookEvents.fetchBookStart;
    payload = path;
  }
  BookEvent.fetchBooksSuccess() {
    type = BookEvents.fetchBookSuccess;
  }
  BookEvent.fetchBooksError() {
    type = BookEvents.fetchBookError;
  }
}
