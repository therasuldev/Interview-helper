// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 0)
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
      : question = data['question'] as String,
        answer = data['answer'] as String;
}
