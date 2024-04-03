part of 'question_bloc.dart';

enum QuestionEvents {
  addQuestionsInitial,
  fetchQuestionsStart,
  fetchQuestionsSuccess,
  fetchQuestionsError,
}

class QuestionEvent {
  QuestionEvents? type;
  Map? payload = {};

  QuestionEvent.addQuestionsInitial(String category, String lang) {
    type = QuestionEvents.addQuestionsInitial;
    payload?['category'] = category;
    payload?['lang'] = lang;
  }
  QuestionEvent.fetchQuestionStart(String category, String lang) {
    type = QuestionEvents.fetchQuestionsStart;
    payload?['category'] = category;
    payload?['lang'] = lang;
  }
  QuestionEvent.fetchQuestionSuccess() {
    type = QuestionEvents.fetchQuestionsSuccess;
  }
  QuestionEvent.fetchQuestionError() {
    type = QuestionEvents.fetchQuestionsError;
  }
}
