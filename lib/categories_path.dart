enum KPath {
  flutter,
  go;

  static String? kpath(KPath kPath) {
    switch (kPath) {
      case KPath.flutter:
        return 'flutter/';
      case KPath.go:
        return 'go/';
    }
  }
}
