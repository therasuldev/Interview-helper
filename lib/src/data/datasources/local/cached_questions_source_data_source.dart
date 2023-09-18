import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:interview_prep/src/utils/constants/constant.dart';
import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

abstract class CachedQuestionsSourceDataSource {
  Future<List<Map<String, dynamic>>> fetchQuestionsFromSource({String? type});
}

class CachedQuestionsSourceDataSourceImpl implements CachedQuestionsSourceDataSource {
  CachedQuestionsSourceDataSourceImpl({required CacheService cacheService}): _cacheService = cacheService;
  final CacheService _cacheService;

  @override
  Future<List<Map<String, dynamic>>> fetchQuestionsFromSource({String? type}) async {
    List<Map<String, dynamic>> questions = [];

    var jsonV = await rootBundle.loadString('${Constant.questionPath}/$type.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonV);


    var jsonList = jsonMap.values.toList();
    List<Map<String, dynamic>> typedJsonList = jsonList.cast<Map<String, dynamic>>();
    questions.addAll(typedJsonList);

    _cacheService.cachedquestions.put(type, questions);
    return await _completedFetchQuestionsSource(type!);
  }

  Future<List<Map<String, dynamic>>> _completedFetchQuestionsSource(String category) async {
    return await _cacheService.cachedquestions.get(category);
  }
}
