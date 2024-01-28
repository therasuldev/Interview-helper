// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 3)
class Question {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;
  Question({
    required this.question,
    required this.answer,
  });

  Question.fromJson(Map<String, dynamic> data)
      : question = data['question'],
        answer = data['answer'];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question': question});
    result.addAll({'answer': answer});

    return result;
  }

  String toJson() => json.encode(toMap());
}
