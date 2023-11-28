import 'base/base_cache_service.dart';

abstract class CachedQuestionsSourceData {
  Future<List<Map<String, dynamic>>> getQuestionsFromSource({String? category});
}

class CachedQuestionsSourceDataImpl implements CachedQuestionsSourceData {
  CachedQuestionsSourceDataImpl() : _cacheService = CacheService();
  late final CacheService _cacheService;

  @override
  Future<List<Map<String, dynamic>>> getQuestionsFromSource({String? category}) async {
    return _cacheService.cachedquestions.get(category);
  }
}
