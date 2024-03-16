import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 3)
class Question extends Equatable {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;

  const Question({required this.question, required this.answer});

  factory Question.fromJson(Map<String, dynamic> data) {
    return Question(question: data['question'], answer: data['answer']);
  }

  @override
  List<Object?> get props => [question, answer];
}
