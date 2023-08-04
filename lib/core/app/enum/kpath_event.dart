enum Path {
  flutter,
  go,
  backend,
  cplusplus,
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
  kotlin,
  typescript,
  rust,
  scala,
  swift;

  static String? getPath(Path path) {
    switch (path) {
      case Path.flutter:
        return 'flutter/';
      case Path.go:
        return 'go/';
      case Path.backend:
        return 'backend/';
      case Path.cplusplus:
        return 'cplusplus/';
      case Path.csharp:
        return 'csharp/';
      case Path.cybersecurity:
        return 'cybersecurity/';
      case Path.dataanalyst:
        return 'dataanalyst/';
      case Path.datascientist:
        return 'datascientist/';
      case Path.engineer:
        return 'engineer/';
      case Path.frontend:
        return 'frontend/';
      case Path.git:
        return 'git/';
      case Path.java:
        return 'java/';
      case Path.js:
        return 'js/';
      case Path.nodejs:
        return 'nodejs/';
      case Path.perl:
        return 'perl/';
      case Path.php:
        return 'php/';
      case Path.python:
        return 'python/';
      case Path.react:
        return 'react/';
      case Path.ruby:
        return 'ruby/';
      case Path.rust:
        return 'rust/';
      case Path.kotlin:
        return 'kotlin/';
      case Path.typescript:
        return 'typescript/';
      case Path.scala:
        return 'scala/';
      case Path.swift:
        return 'swift/';
    }
  }
}
