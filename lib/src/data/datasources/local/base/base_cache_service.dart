import 'package:hive/hive.dart';
import 'package:interview_helper/src/domain/models/book/book_category.dart';
import 'package:interview_helper/src/domain/models/question/question_category.dart';

class CacheService {
  Box get cachedquestions => Hive.box('questions');
  Box<QuestionCategory> get bookmarkedQuestionsCategories => Hive.box('question-categories');
  Box<BookCategory> get bookmarkedBooksCategories => Hive.box('book-categories');
}
