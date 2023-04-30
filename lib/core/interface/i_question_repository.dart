abstract class IQuestionRepository {
  Future<List<Map<String, dynamic>>> loadQuestions({String? type});
  Future<List<Map<String, dynamic>>> getQuestions(String category);
}
