// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 0)
class Question {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String question;
  @HiveField(2)
  final String answer;
  Question({
    required this.id,
    required this.question,
    required this.answer,
  });

  Question.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        question = data['question'],
        answer = data['answer'];
}
