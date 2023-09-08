import 'package:flutter_interview_questions/core/model/error/error_model.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';

import '../../app/enum/question.dart';

class QuestionState {
  final QuestionEvents? event;
  final List<Question>? questions;
  final bool? loading;
  final ExceptionModel? error;
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
    ExceptionModel? error,
  }) {
    return QuestionState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      questions: questions ?? this.questions,
      error: error ?? this.error,
    );
  }

  QuestionState.unknown([questions = const <Question>[]])
      : this(
          event: null,
          questions: questions,
          loading: true,
          error: null,
        );
}
