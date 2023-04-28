import 'package:bloc/bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_state.dart';
import 'package:flutter_interview_questions/core/repository/question_repository.dart';
import 'package:flutter_interview_questions/core/utils/enum.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  //TODO: fix me
  final QuestionRepository questionRepository =
      QuestionRepository(path: DataPath.flutter);

  QuestionBloc() : super(QuestionState()) {
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

    //cache.questions.
  }
}
