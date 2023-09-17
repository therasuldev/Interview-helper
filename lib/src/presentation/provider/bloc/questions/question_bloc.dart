import 'package:bloc/bloc.dart';

import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';
import 'package:interview_prep/src/data/datasources/local/cached_questions_source_data_source.dart';
import 'package:interview_prep/src/domain/models/error/error_model.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';
import 'package:interview_prep/src/utils/enum/question.dart';

part  'question_event.dart';
part  'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final questionRepository = CachedQuestionsSourceDataSourceImpl(
    cacheService: CacheService(),
  );

  QuestionBloc() : super(QuestionState.unknown()) {
    on<QuestionEvent>((event, emit) {
      switch (event.type) {
        case QuestionEvents.fetchQuestionStart:
          return _onFetchQuestionStart(event);
        default:
      }
    });
  }

  _onFetchQuestionStart(dynamic event) async {
    emit(state.copyWith(event: event.type, loading: true));

    try {
      final data =
          await questionRepository.fetchQuestionsFromSource(type: event.payload);

      final questions = data.map((question) {
        return Question.fromJson(question);
      }).toList();

      emit(
        state.copyWith(
          questions: questions,
          loading: false,
          event: QuestionEvents.fetchQuestionSuccess,
          error: null,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: QuestionEvents.fetchQuestionError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }
}
