// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_interview_questions/core/app/constant.dart';

import 'package:flutter_interview_questions/core/interface/i_question_repository.dart';
import 'package:flutter_interview_questions/core/cache/cache_service.dart';

class QuestionRepository extends IQuestionRepository {
  QuestionRepository({
    CacheService? cacheService,
  }) : _cacheService = cacheService ?? CacheService();

  final CacheService _cacheService;

  @override
  Future<List<Map<String, dynamic>>> fetchQuestionStart({String? type}) async {
    List<Map<String, dynamic>> questions = [];

    var jsonV =
        await rootBundle.loadString('${Constant.questionPath}/$type.json');
    Map<String, dynamic> jsonMap = await json.decode(jsonV);

    for (var i = 1; i <= jsonMap.length; i++) {
      questions.add(jsonMap['$i']);
    }

    _cacheService.questions.put(type, questions);
    return await fetchQuestionSuccess(type!);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchQuestionSuccess(
      String category) async {
    return await _cacheService.questions.get(category);
  }
}
