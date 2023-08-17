import 'package:flutter_interview_questions/core/app/enum/lang_type_enum.dart';

class AllLanguages {
  static final Set<String> _allLibrary = {
    TypeLibrary.flutter.name,
    TypeLibrary.go.name,
    TypeLibrary.csharp.name,
    TypeLibrary.java.name,
    TypeLibrary.python.name,
    TypeLibrary.ruby.name,
    TypeLibrary.kotlin.name,
    TypeLibrary.typescript.name,
    TypeLibrary.nodejs.name,
    TypeLibrary.perl.name,
    TypeLibrary.php.name,
    TypeLibrary.cplusplus.name,
    TypeLibrary.scala.name,
    TypeLibrary.swift.name,
    TypeLibrary.rust.name,
    TypeLibrary.js.name,
    TypeLibrary.react.name,
    TypeLibrary.cybersecurity.name,
    TypeLibrary.git.name,
  };

   static final Set<String> _allHome = {
    TypeHome.flutter.name,
    TypeHome.go.name,
    TypeHome.csharp.name,
    TypeHome.java.name,
    TypeHome.python.name,
    TypeHome.ruby.name,
    TypeHome.kotlin.name,
    TypeHome.typescript.name,
    TypeHome.nodejs.name,
    TypeHome.perl.name,
    TypeHome.php.name,
    TypeHome.cplusplus.name,
    TypeHome.scala.name,
    TypeHome.swift.name,
    TypeHome.rust.name,
    TypeHome.js.name,
    TypeHome.react.name,
    TypeHome.backend.name,
    TypeHome.cybersecurity.name,
    TypeHome.dataanalyst.name,
    TypeHome.datascientist.name,
    TypeHome.engineer.name,
    TypeHome.frontend.name,
    TypeHome.git.name,
  };

  static List<String> get allLibrary => List<String>.unmodifiable(_allLibrary);
  static List<String> get allHome => List<String>.unmodifiable(_allHome);
}
