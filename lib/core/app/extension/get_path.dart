import 'package:flutter_interview_questions/core/app/constant.dart';

extension DataPathExtension on String {
  String getPath() {
    return '${Constant.questionPath}/$this';
  }
}
