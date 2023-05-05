enum QuestionEvents {
  fetchQuestionStart,
  fetchQuestionSuccess,
  fetchQuestionError,

  goToNextQuestion,
  goToPreviousQuestion,
}

class QuestionEvent {
  QuestionEvents? type;
  dynamic payload;

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
  QuestionEvent.goToNextQuestion(int index) {
    type = QuestionEvents.goToNextQuestion;
    payload = index;
  }
  QuestionEvent.goToPreviousQuestion(int index) {
    type = QuestionEvents.goToPreviousQuestion;
    payload = index;
  }
}
