import 'package:hive/hive.dart';
import 'package:interview_helper/src/domain/models/index.dart';

part 'question_category.g.dart';

@HiveType(typeId: 2)
class QuestionCategory {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Question>? questions;

  QuestionCategory({
    required this.name,
    this.questions,
  });

  void addQuestion(Question question) async {
    if (!questions!.any((q) => q.question == question.question)) {
      questions!.add(question);
    }
  }

  void removeQuestion(Question question) {
    questions!.removeWhere((q) => q.question == question.question);
  }
}
