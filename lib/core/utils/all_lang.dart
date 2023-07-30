import 'package:flutter_interview_questions/core/app/enum/lang_type_enum.dart';

class AllLanguages {
  static final List<String> _all = [
    Types.flutter.name,
    Types.go.name,
    Types.csharp.name,
    Types.java.name,
    Types.python.name,
    Types.ruby.name,
    Types.nodejs.name,
    Types.perl.name,
    Types.php.name,
    Types.cplasplas.name,
    Types.scala.name,
    Types.swift.name,
    Types.rust.name,
    Types.js.name,
    Types.react.name,
    Types.backend.name,
    Types.cybersecurity.name,
    Types.dataanalyst.name,
    Types.datascientist.name,
    Types.engineer.name,
    Types.frontend.name,
    Types.git.name,
  ];

  static List<String> get all => List<String>.unmodifiable(_all);
}
