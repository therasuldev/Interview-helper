import 'package:flutter_interview_questions/core/model/error/error_model.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';

class QuestionState {
  final QuestionEvents? event;
  final List<Question>? questions;
  final bool? loading;
  final ErrorModel? error;
  QuestionState({
    this.event,
    this.loading,
    this.error,
    this.questions,
  });

  QuestionState copyWith({
    QuestionEvents? event,
    List<Question>? questions,
    bool? loading,
    ErrorModel? error,
  }) {
    return QuestionState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      questions: questions ?? this.questions,
      error: error ?? this.error,
    );
  }

  QuestionState.unknown([question = const <Question>[]])
      : this(
          event: null,
          questions: question,
          loading: true,
          error: null,
        );
}
