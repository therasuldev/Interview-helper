import 'package:flutter_interview_questions/core/model/question/question.dart';

class Category {
  final String image;
  final String name;
  final String category;
  final List<Question> questions;
  Category({
    required this.image,
    required this.name,
    required this.category,
    required this.questions,
  });

  Category copyWith({
    String? image,
    String? name,
    String? category,
    List<Question>? questions,
  }) {
    return Category(
      image: image ?? this.image,
      name: name ?? this.name,
      category: category ?? this.category,
      questions: questions ?? this.questions,
    );
  }
}
