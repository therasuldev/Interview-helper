part of 'question_bloc.dart';

enum QuestionEvents {
  addQuestionsInitial,
  fetchQuestionsStart,
  fetchQuestionsSuccess,
  fetchQuestionsError,
}

class QuestionEvent {
  QuestionEvents? type;
  dynamic payload;

  QuestionEvent.addQuestionsInitial(String category) {
    type = QuestionEvents.addQuestionsInitial;
    payload = category;
  }
  QuestionEvent.fetchQuestionStart(String category) {
    type = QuestionEvents.fetchQuestionsStart;
    payload = category;
  }
  QuestionEvent.fetchQuestionSuccess() {
    type = QuestionEvents.fetchQuestionsSuccess;
  }
  QuestionEvent.fetchQuestionError() {
    type = QuestionEvents.fetchQuestionsError;
  }
}
