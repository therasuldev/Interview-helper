class ScreenDataPaths {
  final Set<String> _libraryCategoryPathNames = {
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
  };

  final Set<String> _homeCategoryPathNames = {
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

  List<String> get libraryCategoryPathNames {
    return List<String>.unmodifiable(_libraryCategoryPathNames);
  }

  List<String> get homeCategoryPathNames {
    return List<String>.unmodifiable(_homeCategoryPathNames);
  }
}
