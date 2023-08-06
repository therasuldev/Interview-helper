import 'package:flutter_interview_questions/core/app/enum/lang_type_enum.dart';

class AllLanguages {
  static final Set<String> _all = {
    Type.flutter.name,
    Type.go.name,
    Type.csharp.name,
    Type.java.name,
    Type.python.name,
    Type.ruby.name,
    Type.kotlin.name,
    Type.typescript.name,
    Type.nodejs.name,
    Type.perl.name,
    Type.php.name,
    Type.cplusplus.name,
    Type.scala.name,
    Type.swift.name,
    Type.rust.name,
    Type.js.name,
    Type.react.name,
    Type.backend.name,
    Type.cybersecurity.name,
    Type.dataanalyst.name,
    Type.datascientist.name,
    Type.engineer.name,
    Type.frontend.name,
    Type.git.name,
  };

  static List<String> get all => List<String>.unmodifiable(_all);
}
