import 'package:bloc/bloc.dart';
import 'package:interview_prep/core/app/enum/question.dart';
import 'package:interview_prep/core/model/error/error_model.dart';
import 'package:interview_prep/core/model/question/question.dart';
import 'package:interview_prep/core/provider/bloc/questions/question_event.dart';
import 'package:interview_prep/core/provider/bloc/questions/question_state.dart';
import 'package:interview_prep/core/repository/question_repository.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository questionRepository = QuestionRepository();

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
          await questionRepository.fetchQuestionStart(type: event.payload);

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
