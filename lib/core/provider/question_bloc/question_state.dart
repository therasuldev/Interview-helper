// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_interview_questions/core/model/error/error_model.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';

class QuestionState {
   final QuestionEvents? event;
  final bool? loading;
  final ErrorModel? error;
  QuestionState({
    this.event,
    this.loading,
    this.error,
  });


  QuestionState copyWith({
    QuestionEvents? event,
    bool? loading,
    ErrorModel? error,
  }) {
    return QuestionState(
      event: event ?? this.event,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
