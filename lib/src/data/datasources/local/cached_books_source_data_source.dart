import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

abstract class CachedBooksSourceDataSource {
  bool containsKey(dynamic key);
  dynamic getBookSources(dynamic key);
  Future<void> putBooks(dynamic key, dynamic value);
}

class CachedBooksSourceDataSourceImpl implements CachedBooksSourceDataSource {
  CachedBooksSourceDataSourceImpl({required this.cacheService});
  final CacheService cacheService;

  @override
  bool containsKey(key) => cacheService.cachedBooks.containsKey(key);

  @override
  dynamic getBookSources(key) async => await cacheService.cachedBooks.get(key);

  @override
  Future<void> putBooks(key, value) async => await cacheService.cachedBooks.put(key, value);
}
