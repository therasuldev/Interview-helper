import 'package:flutter_interview_questions/core/app/extension/get_path.dart';

enum DataPath {
  go,
  flutter,
  backend,
  cplasplas,
  csharp,
  cybersecurity,
  dataanalyst,
  datascientist,
  engineer,
  frontend,
  git,
  java,
  js,
  nodejs,
  perl,
  php,
  python,
  react,
  ruby,
  rust,
  scala,
  swift;

  String getPath() {
    switch (this) {
      case DataPath.flutter:
        return 'flutter'.getPath();
      case DataPath.go:
        return 'go'.getPath();
      case DataPath.backend:
        return 'backend'.getPath();
      case DataPath.cplasplas:
        return 'cplasplas'.getPath();
      case DataPath.csharp:
        return 'csharp'.getPath();
      case DataPath.cybersecurity:
        return 'cybersecurity'.getPath();
      case DataPath.dataanalyst:
        return 'dataanalyst'.getPath();
      case DataPath.datascientist:
        return 'datascientist'.getPath();
      case DataPath.engineer:
        return 'engineer'.getPath();
      case DataPath.frontend:
        return 'frontend'.getPath();
      case DataPath.git:
        return 'git'.getPath();
      case DataPath.java:
        return 'java'.getPath();
      case DataPath.js:
        return 'js'.getPath();
      case DataPath.nodejs:
        return 'nodejs'.getPath();
      case DataPath.perl:
        return 'perl'.getPath();
      case DataPath.php:
        return 'php'.getPath();
      case DataPath.python:
        return 'python'.getPath();
      case DataPath.react:
        return 'react'.getPath();
      case DataPath.ruby:
        return 'ruby'.getPath();
      case DataPath.rust:
        return 'rust'.getPath();
      case DataPath.scala:
        return 'scala'.getPath();
      case DataPath.swift:
        return 'swift'.getPath();
    }
  }
}
