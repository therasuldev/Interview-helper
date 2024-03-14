class CategoryTitles {
  static String getRelatedCollectionName(String category) {
    final categoryCollectionMap = {
      'Flutter & Dart': 'flutter',
      'Go(Lang)': 'go',
      'C++': 'cplusplus',
      'C#': 'csharp',
      'Cyber Security': 'cybersecurity',
      'Git': 'git',
      'Java': 'java',
      'Java Script': 'js',
      'NodeJs': 'nodejs',
      'Perl': 'perl',
      'PHP': 'php',
      'Python': 'python',
      'React': 'react',
      'Ruby': 'ruby',
      'Kotlin': 'kotlin',
      'Typescript': 'typescript',
      'Rust': 'rust',
      'Scala': 'scala',
      'Swift': 'swift',
    };

    return categoryCollectionMap[category] ?? 'unknown';
  }

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
