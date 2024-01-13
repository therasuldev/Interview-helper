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
          return _onaddCategoryInitial(event);
        case CategoryEvents.fetchCategoriesStart:
          return _onFetchCategoriesStart(event);
        default:
      }
    });
  }

  _onaddCategoryInitial(CategoryEvent event) async {
   // var box = Hive.box<Category>('categories');
    final category = CacheService().cachedCategories.get(event.payload) ?? Category(name: event.payload, questions: [event.question!]);
    category.addQuestion(event.question!);

    await CacheService().cachedCategories.putAll({event.payload: category});
  }

  _onFetchCategoriesStart(CategoryEvent event) async {
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

  late final CachedQuestionsSourceDataImpl _questionRepository;
}
