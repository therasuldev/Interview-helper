// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import 'package:interview_prep/src/data/datasources/local/cached_questions_source_data_source.dart';
import 'package:interview_prep/src/domain/models/error/error_model.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';
import 'package:interview_prep/src/utils/enum/question.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final questionRepository = CachedQuestionsSourceDataSourceImpl();

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
    emit(state.copyWith(loading: true));

    try {
      final questionSources = await questionRepository.fetchQuestionsFromSource(category: event.payload);
      final questions = questionSources?.map((question) => Question.fromJson(question)).toList();

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
