import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

abstract class CachedQuestionsSourceDataSource {
  Future<List<Map<String, dynamic>>> getQuestionsFromSource({String? category});
}

class CachedQuestionsSourceDataSourceImpl implements CachedQuestionsSourceDataSource {
  CachedQuestionsSourceDataSourceImpl({required CacheService cacheService}) : _cacheService = cacheService;
  @override
  Future<List<Map<String, dynamic>>> getQuestionsFromSource({String? category}) async {
    return _cacheService.cachedquestions.get(category);
  }

  final CacheService _cacheService;
}
