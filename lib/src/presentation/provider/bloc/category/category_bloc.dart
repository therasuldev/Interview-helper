// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:interview_helper/src/data/datasources/local/base/base_cache_service.dart';
import 'package:interview_helper/src/data/datasources/local/bookmarked_books_source_data.dart';
import 'package:interview_helper/src/data/datasources/local/bookmarked_questions_source_data.dart';
import 'package:interview_helper/src/domain/models/book/book_category.dart';
import 'package:interview_helper/src/domain/models/question/question_category.dart';

import '../../../../domain/models/index.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc()
      : _bookmarkedQuestionsSourceDataImpl = BookmarkedQuestionsSourceDataImpl(),
        _bookmarkedBooksSourceDataImpl = BookmarkedBooksSourceDataImpl(),
        super(CategoryState.unknown()) {
    on<CategoryEvent>((event, emit) {
      switch (event.type) {
        case CategoryEvents.bookmarkQuestionInitial:
          _onBookmarkQuestionInitial(event);
          break;
        case CategoryEvents.removeBookmarkedQuestion:
          _onRemoveBookmarkedQuestion(event);
          break;
        case CategoryEvents.fetchBookmarkedQuestionsStart:
          _onFetchBookmarkedQuestionsStart(event);
          break;
        case CategoryEvents.fetchBookmarkedQuestionsForCategory:
          _onFetchBookmarkedQuestionsForCategory(event);
          break;
        case CategoryEvents.bookmarkBookInitial:
          _onBookmarkBookInitial(event);
          break;
        case CategoryEvents.removeBookmarkedBook:
          _onRemoveBookmarkedBook(event);
          break;
        case CategoryEvents.fetchBookmarkedBooksStart:
          _onFetchBookmarkedBooksStart(event);
          break;
        case CategoryEvents.fetchBookmarkedBooksForCategory:
          _onFetchBookmarkedBooksForCategory(event);
          break;

        default:
      }
    });
  }

  void _onBookmarkQuestionInitial(CategoryEvent event) async {
    var category = CacheService().bookmarkedQuestionsCategories.get(event.payload);

    if (category == null) {
      category = QuestionCategory(name: event.payload, questions: []);
      category.addQuestion(event.question!);
    } else {
      category.addQuestion(event.question!);
    }

    //TODO:fix
    await CacheService().bookmarkedQuestionsCategories.put(event.payload, category);
    final questions = await _bookmarkedQuestionsSourceDataImpl.getBookmarkedQuestionsByCategory(event.payload);

    emit(
      state.copyWith(
        loading: false,
        questions: questions,
        event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
      ),
    );
  }

  void _onRemoveBookmarkedQuestion(CategoryEvent event) async {
    var category = CacheService().bookmarkedQuestionsCategories.get(event.payload);

    if (category != null) {
      category.removeQuestion(event.question!);

      await CacheService().bookmarkedQuestionsCategories.put(event.payload, category);
      final questions = await _bookmarkedQuestionsSourceDataImpl.getBookmarkedQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
        ),
      );
    }
  }

  void _onFetchBookmarkedQuestionsStart(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final questionCategories = await _bookmarkedQuestionsSourceDataImpl.getQuestionCategoriesFromSource();

      emit(
        state.copyWith(
          loading: false,
          questionCategories: questionCategories,
          event: CategoryEvents.fetchBookmarkedQuestionsSuccess,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questionCategories: [],
          loading: true,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  void _onFetchBookmarkedQuestionsForCategory(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final bookmarkedQuestions = await _bookmarkedQuestionsSourceDataImpl.getBookmarkedQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: bookmarkedQuestions,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategory,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: CategoryEvents.fetchBookmarkedQuestionsForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  void _onBookmarkBookInitial(CategoryEvent event) async {
    var category = CacheService().bookmarkedBooksCategories.get(event.payload);

    if (category == null) {
      category = BookCategory(name: event.payload, books: []);
      category.addBook(event.book!);
    } else {
      category.addBook(event.book!);
    }

    //TODO:fix
    await CacheService().bookmarkedBooksCategories.put(event.payload, category);
    final books = await _bookmarkedBooksSourceDataImpl.getBookmarkedBooksByCategory(event.payload);

    emit(
      state.copyWith(
        loading: false,
        books: books,
        event: CategoryEvents.fetchBookmarkedBooksForCategory,
      ),
    );
  }

  void _onRemoveBookmarkedBook(CategoryEvent event) async {
    var category = CacheService().bookmarkedBooksCategories.get(event.payload);

    if (category != null) {
      category.removeBook(event.book!);

      await CacheService().bookmarkedBooksCategories.put(event.payload, category);
      final books = await _bookmarkedBooksSourceDataImpl.getBookmarkedBooksByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          books: books,
          event: CategoryEvents.fetchBookmarkedBooksForCategory,
        ),
      );
    }
  }

  void _onFetchBookmarkedBooksStart(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final bookCategories = await _bookmarkedBooksSourceDataImpl.getBookCategoriesFromSource();

      emit(
        state.copyWith(
          loading: false,
          bookCategories: bookCategories,
          event: CategoryEvents.fetchBookmarkedBooksSuccess,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          bookCategories: [],
          loading: true,
          event: CategoryEvents.fetchBookmarkedBooksForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  void _onFetchBookmarkedBooksForCategory(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final bookmarkedBooks = await _bookmarkedBooksSourceDataImpl.getBookmarkedBooksByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          books: bookmarkedBooks,
          event: CategoryEvents.fetchBookmarkedBooksForCategory,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          books: [],
          loading: true,
          event: CategoryEvents.fetchBookmarkedBooksForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  late final BookmarkedQuestionsSourceDataImpl _bookmarkedQuestionsSourceDataImpl;
  late final BookmarkedBooksSourceDataImpl _bookmarkedBooksSourceDataImpl;
}
