class CategoryTitles {
  static final Set<String> _libraryCategory = {
    'Flutter & Dart',
    'Go(Lang)',
    'C++',
    'C#',
    'Cyber Security',
    'Git',
    'Java',
    'Java Script',
    'NodeJs',
    'Perl',
    'PHP',
    'Python',
    'React',
    'Ruby',
    'Kotlin',
    'Typescript',
    'Rust',
    'Scala',
    'Swift',
  };

  static final Set<String> _homeCategory = {
    'flutter',
    'go',
    'java',
    'python',
    'ruby',
    'kotlin',
    'typescript',
    'rust',
    'js',
    'react',
    'csharp',
    'nodejs',
    'perl',
    'php',
    'scala',
    'swift',
    'cplusplus',
    'git',
    'cybersecurity',
    'backend',
    'dataanalyst',
    'datascientist',
    'engineer',
    'frontend',
  };

  static List<String> get libraryCategory {
    return List<String>.unmodifiable(_libraryCategory);
  }

  static List<String> get homeCategory {
    return List<String>.unmodifiable(_homeCategory);
  }
}
