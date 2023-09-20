import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:interview_prep/src/utils/constants/constant.dart';
import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

abstract class CachedQuestionsSourceDataSource {
  Future<List<Map<String, dynamic>>?> fetchQuestionsFromSource({String? category});
}

class CachedQuestionsSourceDataSourceImpl with CachedQuestionsSourceDataSourceMixin implements CachedQuestionsSourceDataSource {
  @override
  Future<List<Map<String, dynamic>>?> fetchQuestionsFromSource({String? category}) async {
    final cachedQuestions = await _getQuestionSourcesFromCache(category);
    // If there are questions in the cache, it should retrieve them from the cache
    // without re-reading the file; if there are no questions in the cache, it should
    // read them from the file and write them to the cache.
    if(cachedQuestions==null || cachedQuestions.isEmpty) await _writeToCache(category);
    
    return _getQuestionSourcesFromCache(category);
  }
}

mixin CachedQuestionsSourceDataSourceMixin { 
  final CacheService _cacheService = CacheService();

  Future<List<Map<String, dynamic>>?> _getQuestionSourcesFromCache(String? category) async {
    return _cacheService.cachedquestions.get(category);
  }

  Future<void> _writeToCache(String? category) async {
    final jsonV = await rootBundle.loadString('${Constant.questionPath}/$category.json');
    final Map<String, dynamic> jsonMap = await json.decode(jsonV);
    final List<Map<String, dynamic>> questions = [];

    for (var i = 1; i <= jsonMap.length; i++) {questions.add(jsonMap['$i']);}
    await _cacheService.cachedquestions.put(category, questions);
  }
}