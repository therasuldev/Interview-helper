// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:interview_prep/src/data/datasources/local/base/base_cache_service.dart';

import 'package:interview_prep/src/data/datasources/local/cached_questions_source_data_source.dart';
import 'package:interview_prep/src/domain/models/error/error_model.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';
import 'package:interview_prep/src/utils/constants/constant.dart';
import 'package:interview_prep/src/utils/enum/question.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final questionRepository = CachedQuestionsSourceDataSourceImpl(cacheService: CacheService());

  QuestionBloc() : super(QuestionState.unknown()) {
    on<QuestionEvent>((event, emit) {
      switch (event.type) {
        case QuestionEvents.addQuestionsInitial:
          return _onAddQuestionsToCache(event);
        case QuestionEvents.fetchQuestionStart:
          return _onFetchQuestionStart(event);
        default:
      }
    });
  }

  _onAddQuestionsToCache(dynamic event) async {
    final jsonStr = await rootBundle.loadString('${Constant.questionPath}/${event.payload}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);

    final List<Map<String, dynamic>> questions = [];
    for (var i = 1; i <= jsonMap.length; i++) {
      questions.add(jsonMap['$i']);
    }
    await CacheService().cachedquestions.put(event.payload, questions);
  }

  _onFetchQuestionStart(dynamic event) async {
    emit(state.copyWith(loading: true));

    try {
      final questionSources = await questionRepository.getQuestionsFromSource(category: event.payload);
      final questions = questionSources.map((question) => Question.fromJson(question)).toList();

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: QuestionEvents.fetchQuestionSuccess,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: QuestionEvents.fetchQuestionError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }
}
