part of 'category_bloc.dart';

enum CategoryEvents {
  addCategoryInitial,
  fetchCategoriesStart,
  fetchCategoriesSuccess,
  fetchCategoriesError,
}

class CategoryEvent {
  CategoryEvents? type;
  dynamic payload;
  Question? question;

  CategoryEvent.addCategoryInitial(String category, Question this.question) {
    type = CategoryEvents.addCategoryInitial;
    payload = category;
  }
  CategoryEvent.fetchCategoriesStart() {
    type = CategoryEvents.fetchCategoriesStart;
  }
  CategoryEvent.fetchCategoriesSuccess() {
    type = CategoryEvents.fetchCategoriesSuccess;
  }
  CategoryEvent.fetchCategoriesError() {
    type = CategoryEvents.fetchCategoriesError;
  }
}
