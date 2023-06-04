part of 'books_bloc.dart';

enum BookEvents {
  fetchBookStart,
  fetchBookSuccess,
  fetchBookError,
}

class BookEvent {
  BookEvents? type;
  dynamic payload;

  BookEvent.fetchQuestionStart(String category) {
    type = BookEvents.fetchBookStart;
    payload = category;
  }
  BookEvent.fetchQuestionSuccess() {
    type = BookEvents.fetchBookSuccess;
  }
  BookEvent.fetchQuestionError() {
    type = BookEvents.fetchBookError;
  }
}
