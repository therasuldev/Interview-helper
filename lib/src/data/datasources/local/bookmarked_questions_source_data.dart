import 'package:interview_helper/src/data/datasources/local/base/base_cache_service.dart';
import 'package:interview_helper/src/domain/models/index.dart';
import 'package:interview_helper/src/domain/models/question/question_category.dart';

abstract class BookmarkedQuestionsSourceData {
  Future<List<Question>> getBookmarkedQuestionsByCategory(String categoryName);
  Future<List<QuestionCategory>> getQuestionCategoriesFromSource();
}

class BookmarkedQuestionsSourceDataImpl implements BookmarkedQuestionsSourceData {
  BookmarkedQuestionsSourceDataImpl() : _cacheService = CacheService();
  late final CacheService _cacheService;
  @override
  Future<List<QuestionCategory>> getQuestionCategoriesFromSource() async {
    final datas = _cacheService.bookmarkedQuestionsCategories.values.where((category) {
      return category.questions!.isNotEmpty;
    });
    return datas.toList().cast();
  }

  @override
  Future<List<Question>> getBookmarkedQuestionsByCategory(String categoryName) async {
    final category = _cacheService.bookmarkedQuestionsCategories.get(categoryName);
    if (category != null && category.questions!.isNotEmpty) {
      return category.questions!;
    }
    return [];
  }
}
