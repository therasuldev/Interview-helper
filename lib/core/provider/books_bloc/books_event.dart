part of 'books_bloc.dart';

enum BookEvents {
  fetchBookStart,
  fetchBookSuccess,
  fetchBookError,
}

class BookEvent {
  BookEvents? type;
  dynamic payload;

  BookEvent.fetchQuestionStart(List<KPath> path) {
    type = BookEvents.fetchBookStart;
    payload = path;
  }
  BookEvent.fetchQuestionSuccess() {
    type = BookEvents.fetchBookSuccess;
  }
  BookEvent.fetchQuestionError() {
    type = BookEvents.fetchBookError;
  }
}
