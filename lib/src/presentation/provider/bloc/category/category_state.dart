part of 'category_bloc.dart';

class CategoryState {
  final CategoryEvents? event;
  final List<Category>? categories;
  final bool? loading;
  final ExceptionModel? error;

  CategoryState({
    this.event,
    this.loading,
    this.error,
    this.categories,
  });

  CategoryState copyWith({
    CategoryEvents? event,
    List<Category>? categories,
    bool? loading,
    ExceptionModel? error,
  }) {
    return CategoryState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }

  factory CategoryState.unknown([categories = const <Category>[]]) {
    return CategoryState(
      event: null,
      categories: categories,
      loading: true,
      error: null,
    );
  }
}
