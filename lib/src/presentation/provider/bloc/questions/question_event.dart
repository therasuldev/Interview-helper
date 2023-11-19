part of 'question_bloc.dart';

class QuestionEvent {
  QuestionEvents? type;
  dynamic payload;

  QuestionEvent.addQuestionsInitial(String category) {
    type = QuestionEvents.addQuestionsInitial;
    payload = category;
  }
  QuestionEvent.fetchQuestionStart(String category) {
    type = QuestionEvents.fetchQuestionStart;
    payload = category;
  }
  QuestionEvent.fetchQuestionSuccess() {
    type = QuestionEvents.fetchQuestionSuccess;
  }
  QuestionEvent.fetchQuestionError() {
    type = QuestionEvents.fetchQuestionError;
  }
}
