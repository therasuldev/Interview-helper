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

enum Types {
  flutter('flutter'),
  go('go'),
  java('java'),
  python('python'),
  ruby('ruby'),
  rust('rust'),
  js('js'),
  react('react');

  const Types(this.type);
  final String type;
}

enum Titles {
  flutter('Flutter'),
  go('Go Lang'),
  java('Java'),
  python('Python'),
  ruby('Ruby'),
  rust('Rust'),
  js('Java Script'),
  react('React');

  const Titles(this.title);
  final String title;
}
