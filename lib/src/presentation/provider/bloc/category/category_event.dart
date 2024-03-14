part of 'category_bloc.dart';

enum CategoryEvents {
  bookmarkQuestionInitial,
  fetchBookmarkedQuestionsStart,
  fetchBookmarkedQuestionsSuccess,
  fetchBookmarkedQuestionsError,

  fetchBookmarkedQuestionsForCategory,
  fetchBookmarkedQuestionsForCategoryError,
  removeBookmarkedQuestion,

  bookmarkBookInitial,
  fetchBookmarkedBooksStart,
  fetchBookmarkedBooksSuccess,
  fetchBookmarkedBooksError,

  fetchBookmarkedBooksForCategory,
  fetchBookmarkedBooksForCategoryError,
  removeBookmarkedBook,
}

class CategoryEvent {
  CategoryEvents? type;
  dynamic payload;
  Question? question;
  Book? book;

  CategoryEvent.bookmarkQuestionInitial(String category, this.question) {
    type = CategoryEvents.bookmarkQuestionInitial;
    payload = category;
  }
  CategoryEvent.fetchBookmarkedQuestionsStart() {
    type = CategoryEvents.fetchBookmarkedQuestionsStart;
  }
  CategoryEvent.fetchBookmarkedQuestionsSuccess() {
    type = CategoryEvents.fetchBookmarkedQuestionsSuccess;
  }
  CategoryEvent.fetchBookmarkedQuestionsError() {
    type = CategoryEvents.fetchBookmarkedQuestionsError;
  }

  CategoryEvent.fetchBookmarkedQuestionsForCategory(String categoryName) {
    type = CategoryEvents.fetchBookmarkedQuestionsForCategory;
    payload = categoryName;
  }
  CategoryEvent.removeBookmarkedQuestion(String categoryName, this.question) {
    type = CategoryEvents.removeBookmarkedQuestion;
    payload = categoryName;
  }
  CategoryEvent.fetchBookmarkedQuestionsForCategoryError() {
    type = CategoryEvents.fetchBookmarkedQuestionsForCategoryError;
  }

  CategoryEvent.bookmarkBookInitial(String category, this.book) {
    type = CategoryEvents.bookmarkBookInitial;
    payload = category;
  }
  CategoryEvent.fetchBookmarkedBooksStart() {
    type = CategoryEvents.fetchBookmarkedBooksStart;
  }

  CategoryEvent.fetchBookmarkedBooksForCategory(String categoryName) {
    type = CategoryEvents.fetchBookmarkedBooksForCategory;
    payload = categoryName;
  }

  CategoryEvent.fetchBookmarkedBooksForCategoryError() {
    type = CategoryEvents.fetchBookmarkedBooksForCategoryError;
  }

  CategoryEvent.removeBookmarkedBook(String categoryName, this.book) {
    type = CategoryEvents.removeBookmarkedBook;
    payload = categoryName;
  }
}
