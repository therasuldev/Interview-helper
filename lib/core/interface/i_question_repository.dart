abstract class IQuestionRepository {
  Future<List<Map<String, dynamic>>> loadQuestions(String category);
  Future<List<Map<String, dynamic>>> getQuestions(String category);
}
