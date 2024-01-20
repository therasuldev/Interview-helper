part of 'category_bloc.dart';

enum CategoryEvents {
  addCategoryInitial,
  fetchCategoriesStart,
  fetchCategoriesSuccess,
  fetchCategoriesError,

  fetchQuestionsForCategory,
  fetchQuestionsForCategoryError,
  removeQuestionFromCategory
}

class CategoryEvent {
  CategoryEvents? type;
  dynamic payload;
  Question? question;

  CategoryEvent.addCategoryInitial(String category, this.question) {
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

  CategoryEvent.fetchQuestionsForCategory(String categoryName) {
    type = CategoryEvents.fetchQuestionsForCategory;
    payload = categoryName;
  }
  CategoryEvent.removeQuestionFromCategory(String categoryName, this.question) {
    type = CategoryEvents.removeQuestionFromCategory;
    payload = categoryName;
  }
  CategoryEvent.fetchQuestionsForCategoryError() {
    type = CategoryEvents.fetchQuestionsForCategoryError;
  }
}
