enum DataPath {
  go,
  flutter;

  String getPath() {
    switch (this) {
      case DataPath.flutter:
        return 'assets/prg_lang/flutter';
      case DataPath.go:
        return 'assets/prg_lang/go';
    }
  }
}