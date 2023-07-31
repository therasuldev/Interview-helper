abstract class ICacheRepository {
  bool containsKey(dynamic key);
  Future<void> put(dynamic key, dynamic value);
  dynamic get(dynamic key);
}
