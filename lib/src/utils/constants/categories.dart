import 'package:interview_helper/gen/assets.gen.dart';

import '../../presentation/widgets/index.dart';
import '../index.dart';

class CategoryCards {
  static CategoryCard? cards(String name) {
    switch (name) {
      case 'flutter':
        return CategoryCard(
          image: Assets.icons.flutter.path,
          category: CategoryCardTitles.flutter.category,
        );
      case 'go':
        return CategoryCard(
          image: Assets.icons.go.path,
          category: CategoryCardTitles.go.category,
        );
      case 'java':
        return CategoryCard(
          image: Assets.icons.java.path,
          category: CategoryCardTitles.java.category,
        );
      case 'python':
        return CategoryCard(
          image: Assets.icons.python.path,
          category: CategoryCardTitles.python.category,
        );
      case 'ruby':
        return CategoryCard(
          image: Assets.icons.ruby.path,
          category: CategoryCardTitles.ruby.category,
        );
      case 'kotlin':
        return CategoryCard(
          image: Assets.icons.kotlin.path,
          category: CategoryCardTitles.kotlin.category,
        );
      case 'typescript':
        return CategoryCard(
          image: Assets.icons.typescript.path,
          category: CategoryCardTitles.typescript.category,
        );
      case 'rust':
        return CategoryCard(
          image: Assets.icons.rust.path,
          category: CategoryCardTitles.rust.category,
        );
      case 'js':
        return CategoryCard(
          image: Assets.icons.js.path,
          category: CategoryCardTitles.js.category,
        );
      case 'react':
        return CategoryCard(
          image: Assets.icons.react.path,
          category: CategoryCardTitles.react.category,
        );
      case 'csharp':
        return CategoryCard(
          image: Assets.icons.csharp.path,
          category: CategoryCardTitles.csharp.category,
        );
      case 'nodejs':
        return CategoryCard(
          image: Assets.icons.nodejs.path,
          category: CategoryCardTitles.nodejs.category,
        );
      case 'perl':
        return CategoryCard(
          image: Assets.icons.perl.path,
          category: CategoryCardTitles.perl.category,
        );
      case 'php':
        return CategoryCard(
          image: Assets.icons.php.path,
          category: CategoryCardTitles.php.category,
        );
      case 'scala':
        return CategoryCard(
          image: Assets.icons.scala.path,
          category: CategoryCardTitles.scala.category,
        );
      case 'swift':
        return CategoryCard(
          image: Assets.icons.swift.path,
          category: CategoryCardTitles.swift.category,
        );
      case 'git':
        return CategoryCard(
          image: Assets.icons.git.path,
          category: CategoryCardTitles.git.category,
        );
      case 'frontend':
        return CategoryCard(
          image: Assets.icons.frontend.path,
          category: CategoryCardTitles.frontend.category,
        );
      case 'engineer':
        return CategoryCard(
          image: Assets.icons.engineer.path,
          category: CategoryCardTitles.engineer.category,
        );
      case 'datascientist':
        return CategoryCard(
          image: Assets.icons.datascientist.path,
          category: CategoryCardTitles.datascientist.category,
        );
      case 'dataanalyst':
        return CategoryCard(
          image: Assets.icons.dataanalyst.path,
          category: CategoryCardTitles.dataanalyst.category,
        );
      case 'cybersecurity':
        return CategoryCard(
          image: Assets.icons.cybersecurity.path,
          category: CategoryCardTitles.cybersecurity.category,
        );
      case 'cplusplus':
        return CategoryCard(
          image: Assets.icons.cplusplus.path,
          category: CategoryCardTitles.cplusplus.category,
        );
      case 'backend':
        return CategoryCard(
          image: Assets.icons.backend.path,
          category: CategoryCardTitles.backend.category,
        );
      default:
        return null;
    }
  }
}
