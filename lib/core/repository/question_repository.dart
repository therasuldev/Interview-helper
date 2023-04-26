// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter_interview_questions/core/interface/i_question_repository.dart';
import 'package:flutter_interview_questions/core/service/cache_service.dart';
import 'package:flutter_interview_questions/core/utils/enum.dart';

class QuestionRepository extends IQuestionRepository {
  QuestionRepository({
    required CacheService cacheService,
    required DataPath path,
  })  : _cacheService = cacheService,
        _path = path;

  final CacheService _cacheService;
  final DataPath _path;

  @override
  Future<List<Map<String, dynamic>>> loadQuestions(String category) async {
    List<Map<String, dynamic>> questions = [];

    var jsonStr = await rootBundle.loadString('$_path/$category.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonStr);

    for (var i = 1; i <= jsonMap.length; i++) {
      questions.add(jsonMap['$i']);
    }

    _cacheService.questions.put(category, questions);
    return await getQuestions(category);
  }

  @override
  Future<List<Map<String, dynamic>>> getQuestions(String category) async {
    return await _cacheService.questions.get(category);
  }
}
