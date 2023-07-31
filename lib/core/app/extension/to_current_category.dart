import 'package:flutter_interview_questions/core/utils/all_lang.dart';

extension CurrentIndex on List {
  String current(int index) {
    return this[indexWhere((language) {
      return language == AllLanguages.all[index];
    })];
  }
}
