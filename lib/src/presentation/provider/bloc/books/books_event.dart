part of 'books_bloc.dart';

enum BookEvents {
  fetchAllBooksStart,
  fetchBooksSuccess,
  fetchBooksError,

  fetchBooksByCategory,
}

class BookEvent {
  BookEvents? type;
  dynamic payload;

  BookEvent.fetchAllBooksStart() {
    type = BookEvents.fetchAllBooksStart;
  }
  BookEvent.fetchBooksSuccess() {
    type = BookEvents.fetchBooksSuccess;
  }
  BookEvent.fetchBooksError() {
    type = BookEvents.fetchBooksError;
  }

  BookEvent.fetchBooksByCategory(String category) {
    type = BookEvents.fetchBooksByCategory;
    payload = category;
  }
}
