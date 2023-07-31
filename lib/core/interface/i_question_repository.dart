abstract class IQuestionRepository {
  Future<List<Map<String, dynamic>>> fetchQuestionStart({String? type});
  Future<List<Map<String, dynamic>>> fetchQuestionSuccess(String category);
}
