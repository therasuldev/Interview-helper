import 'package:interview_prep/core/interface/i_cache_repository.dart';
import 'package:interview_prep/core/cache/cache_service.dart';

class CacheRepository extends ICacheRepository {
  late CacheService _cacheService;

  CacheRepository() {
    _cacheService = CacheService();
  }

  @override
  bool containsKey(key) {
    final res = _cacheService.downloadedBooks.containsKey(key);
    return res;
  }

  @override
  dynamic get(key) async {
    final res = await _cacheService.downloadedBooks.get(key);
    return res;
  }

  @override
  Future<void> put(key, value) async {
    await _cacheService.downloadedBooks.put(key, value);
  }
}
