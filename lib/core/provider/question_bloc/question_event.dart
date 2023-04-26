enum QuestionEvents {
  fetchQuestionStart,

  fetchQuestionSuccess,

  fetchQuestionError,
}

class QuestionEvent {
  QuestionEvents? type;

  dynamic payload;

  QuestionEvent.fetchQuestionStart() {
    type = QuestionEvents.fetchQuestionStart;
  }
  QuestionEvent.fetchQuestionSuccess() {
    type = QuestionEvents.fetchQuestionSuccess;
  }
  QuestionEvent.fetchQuestionError() {
    type = QuestionEvents.fetchQuestionError;
  }
}
