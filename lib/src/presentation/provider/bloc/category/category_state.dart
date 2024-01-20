part of 'category_bloc.dart';

class CategoryState {
  final CategoryEvents? event;
  final List<Category>? categories;
  final List<Question>? questions;
  final bool? loading;
  final ExceptionModel? error;

  CategoryState({
    this.event,
    this.loading,
    this.error,
    this.categories,
    this.questions,
  });

  CategoryState copyWith({
    CategoryEvents? event,
    List<Category>? categories,
    List<Question>? questions,
    bool? loading,
    ExceptionModel? error,
  }) {
    return CategoryState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      categories: categories ?? this.categories,
      questions: questions ?? this.questions,
      error: error ?? this.error,
    );
  }

  factory CategoryState.unknown([categories = const <Category>[], questions = const <Question>[]]) {
    return CategoryState(
      event: null,
      categories: categories,
      questions: questions,
      loading: true,
      error: null,
    );
  }
}
