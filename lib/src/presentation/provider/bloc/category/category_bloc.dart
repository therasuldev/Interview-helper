// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:interview_helper/src/data/datasources/local/base/base_cache_service.dart';
import 'package:interview_helper/src/data/datasources/local/cached_questions_source_data_source.dart';
import 'package:interview_helper/src/domain/models/question/category.dart';

import '../../../../domain/models/index.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc()
      : _questionRepository = CachedQuestionsSourceDataImpl(),
        super(CategoryState.unknown()) {
    on<CategoryEvent>((event, emit) {
      switch (event.type) {
        case CategoryEvents.addCategoryInitial:
          _onaddCategoryInitial(event);
          break;
        case CategoryEvents.removeQuestionFromCategory:
          _onRemoveQuestionFromCategory(event);
          break;
        case CategoryEvents.fetchCategoriesStart:
          _onFetchCategoriesStart(event);
          break;
        case CategoryEvents.fetchQuestionsForCategory:
          _onLoadQuestionsForCategory(event);
          break;
        default:
      }
    });
  }

  void _onaddCategoryInitial(CategoryEvent event) async {
    var category = CacheService().cachedCategories.get(event.payload);

    if (category == null) {
      category = Category(name: event.payload, questions: []);
      category.addQuestion(event.question!);
    } else {
      category.addQuestion(event.question!);
    }

    //TODO:fix
    await CacheService().cachedCategories.put(event.payload, category);
    final questions = await _questionRepository.getQuestionsByCategory(event.payload);

    emit(
      state.copyWith(
        loading: false,
        questions: questions,
        event: CategoryEvents.fetchQuestionsForCategory,
      ),
    );
  }

  void _onRemoveQuestionFromCategory(CategoryEvent event) async {
    var category = CacheService().cachedCategories.get(event.payload);

    if (category != null) {
      category.removeQuestion(event.question!);

      await CacheService().cachedCategories.put(event.payload, category);
      final questions = await _questionRepository.getQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: CategoryEvents.fetchQuestionsForCategory,
        ),
      );
    }
  }

  void _onFetchCategoriesStart(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final savedQuestions = await _questionRepository.getCategoriesFromSource();

      emit(
        state.copyWith(
          loading: false,
          categories: savedQuestions,
          event: CategoryEvents.fetchCategoriesSuccess,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          categories: [],
          loading: true,
          event: CategoryEvents.fetchCategoriesError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  void _onLoadQuestionsForCategory(CategoryEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final questions = await _questionRepository.getQuestionsByCategory(event.payload);

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: CategoryEvents.fetchQuestionsForCategory,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: CategoryEvents.fetchQuestionsForCategoryError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  late final CachedQuestionsSourceDataImpl _questionRepository;
}
