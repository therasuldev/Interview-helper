enum KPath {
  flutter,
  go,
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

  static String? kpath(KPath kPath) {
    switch (kPath) {
      case KPath.flutter:
        return 'flutter/';
      case KPath.go:
        return 'go/';
      case KPath.backend:
        return 'backend/';
      case KPath.cplasplas:
        return 'cplasplas/';
      case KPath.csharp:
        return 'csharp/';
      case KPath.cybersecurity:
        return 'cybersecurity/';
      case KPath.dataanalyst:
        return 'dataanalyst/';
      case KPath.datascientist:
        return 'datascientist/';
      case KPath.engineer:
        return 'engineer/';
      case KPath.frontend:
        return 'frontend/';
      case KPath.git:
        return 'git/';
      case KPath.java:
        return 'java/';
      case KPath.js:
        return 'js/';
      case KPath.nodejs:
        return 'nodejs/';
      case KPath.perl:
        return 'perl/';
      case KPath.php:
        return 'php/';
      case KPath.python:
        return 'python/';
      case KPath.react:
        return 'react/';
      case KPath.ruby:
        return 'ruby/';
      case KPath.rust:
        return 'rust/';
      case KPath.scala:
        return 'scala/';
      case KPath.swift:
        return 'swift/';
    }
  }
}
