// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:interview_helper/src/data/datasources/local/base/base_cache_service.dart';
import 'package:interview_helper/src/data/datasources/local/cached_questions_source_data.dart';
import 'package:interview_helper/src/utils/index.dart';

import '../../../../domain/models/index.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc()
      : _questionRepository = CachedQuestionsSourceDataImpl(),
        super(QuestionState.unknown()) {
    on<QuestionEvent>((event, emit) {
      switch (event.type) {
        case QuestionEvents.addQuestionsInitial:
          return _onAddQuestionsToCache(event);
        case QuestionEvents.fetchQuestionsStart:
          return _onFetchQuestionStart(event);
        default:
      }
    });
  }

  _onAddQuestionsToCache(QuestionEvent event) async {
    final jsonStr = await rootBundle.loadString('${AssetsPath.questionPath}/${event.payload}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonStr);

    final List<Map<String, dynamic>> questions = [];
    for (var i = 1; i <= jsonMap.length; i++) {
      questions.add(jsonMap['$i']);
    }
    await CacheService().cachedquestions.put(event.payload, questions);
  }

  _onFetchQuestionStart(QuestionEvent event) async {
    emit(state.copyWith(loading: true));

    try {
      final questionSources = await _questionRepository.getQuestionsFromSource(category: event.payload);
      final questions = questionSources.map((question) => Question.fromJson(question)).toList();

      emit(
        state.copyWith(
          loading: false,
          questions: questions,
          event: QuestionEvents.fetchQuestionsSuccess,
        ),
      );
    } catch (exp) {
      emit(
        state.copyWith(
          questions: [],
          loading: true,
          event: QuestionEvents.fetchQuestionsError,
          error: ExceptionModel(description: exp.toString()),
        ),
      );
    }
  }

  late final CachedQuestionsSourceDataImpl _questionRepository;
}
