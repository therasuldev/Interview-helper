import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:interview_prep/src/utils/constants/constant.dart';
import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

abstract class CachedQuestionsSourceDataSource {
  Future<List<Map<String, dynamic>>> fetchQuestionsFromSource({String? type});
}

class CachedQuestionsSourceDataSourceImpl implements CachedQuestionsSourceDataSource {
  CachedQuestionsSourceDataSourceImpl({required this.cacheService});
  final CacheService cacheService;

  @override
  Future<List<Map<String, dynamic>>> fetchQuestionsFromSource({String? type}) async {
    List<Map<String, dynamic>> questions = cacheService.cachedquestions.get(type) ?? [];

    if (questions.isNotEmpty) return _completedFetchQuestionsSource(type!);
    
    try {
      var jsonV = await rootBundle.loadString('${Constant.questionPath}/$type.json');
      List<dynamic> jsonList = json.decode(jsonV);

      questions = jsonList.cast<Map<String, dynamic>>();

      cacheService.cachedquestions.put(type, questions);
      return _completedFetchQuestionsSource(type!);
    } catch (e) {throw e.toString();}
  }

  Future<List<Map<String, dynamic>>> _completedFetchQuestionsSource(String category) async {
    return cacheService.cachedquestions.get(category) ?? [];
  }
}
