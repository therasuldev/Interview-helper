import 'package:interview_helper/src/domain/models/index.dart';

class QuestionViewDetails {
  final String? category;
  final Question question;

  QuestionViewDetails({
    this.category,
    required this.question,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'question': question,
    };
  }
}
