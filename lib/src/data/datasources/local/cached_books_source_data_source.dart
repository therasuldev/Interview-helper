import 'base/base_cache_service.dart';

abstract class CachedBooksSourceDataSource {
  bool containsKey(dynamic key);
  dynamic getBookSources(dynamic key);
  Future<void> putBooks(dynamic key, dynamic value);
}

class CachedBooksSourceDataSourceImpl implements CachedBooksSourceDataSource {
  CachedBooksSourceDataSourceImpl():_cacheService = CacheService();
  late final CacheService _cacheService;

  @override
  bool containsKey(key) => _cacheService.cachedBooks.containsKey(key);

  @override
  dynamic getBookSources(key) async => await _cacheService.cachedBooks.get(key);

  @override
  Future<void> putBooks(key, value) async => await _cacheService.cachedBooks.put(key, value);
}
