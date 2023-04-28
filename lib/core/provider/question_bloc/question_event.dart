enum QuestionEvents {
  fetchQuestionStart,

  fetchQuestionSuccess,

  fetchQuestionError,
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
}
