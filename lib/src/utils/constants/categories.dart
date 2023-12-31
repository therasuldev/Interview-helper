import 'package:interview_helper/gen/assets.gen.dart';

import '../../presentation/widgets/index.dart';
import '../index.dart';

class CategoryCards {
  static CategoryCard? cards(String name) {
    switch (name) {
      case 'flutter':
        return CategoryCard(
          image: Assets.icons.flutter.path,
          title: CategoryCardTitles.flutter.title,
        );
      case 'go':
        return CategoryCard(
          image: Assets.icons.go.path,
          title: CategoryCardTitles.go.title,
        );
      case 'java':
        return CategoryCard(
          image: Assets.icons.java.path,
          title: CategoryCardTitles.java.title,
        );
      case 'python':
        return CategoryCard(
          image: Assets.icons.python.path,
          title: CategoryCardTitles.python.title,
        );
      case 'ruby':
        return CategoryCard(
          image: Assets.icons.ruby.path,
          title: CategoryCardTitles.ruby.title,
        );
      case 'kotlin':
        return CategoryCard(
          image: Assets.icons.kotlin.path,
          title: CategoryCardTitles.kotlin.title,
        );
      case 'typescript':
        return CategoryCard(
          image: Assets.icons.typescript.path,
          title: CategoryCardTitles.typescript.title,
        );
      case 'rust':
        return CategoryCard(
          image: Assets.icons.rust.path,
          title: CategoryCardTitles.rust.title,
        );
      case 'js':
        return CategoryCard(
          image: Assets.icons.js.path,
          title: CategoryCardTitles.js.title,
        );
      case 'react':
        return CategoryCard(
          image: Assets.icons.react.path,
          title: CategoryCardTitles.react.title,
        );
      case 'csharp':
        return CategoryCard(
          image: Assets.icons.csharp.path,
          title: CategoryCardTitles.csharp.title,
        );
      case 'nodejs':
        return CategoryCard(
          image: Assets.icons.nodejs.path,
          title: CategoryCardTitles.nodejs.title,
        );
      case 'perl':
        return CategoryCard(
          image: Assets.icons.perl.path,
          title: CategoryCardTitles.perl.title,
        );
      case 'php':
        return CategoryCard(
          image: Assets.icons.php.path,
          title: CategoryCardTitles.php.title,
        );
      case 'scala':
        return CategoryCard(
          image: Assets.icons.scala.path,
          title: CategoryCardTitles.scala.title,
        );
      case 'swift':
        return CategoryCard(
          image: Assets.icons.swift.path,
          title: CategoryCardTitles.swift.title,
        );
      case 'git':
        return CategoryCard(
          image: Assets.icons.git.path,
          title: CategoryCardTitles.git.title,
        );
      case 'frontend':
        return CategoryCard(
          image: Assets.icons.frontend.path,
          title: CategoryCardTitles.frontend.title,
        );
      case 'engineer':
        return CategoryCard(
          image: Assets.icons.engineer.path,
          title: CategoryCardTitles.engineer.title,
        );
      case 'datascientist':
        return CategoryCard(
          image: Assets.icons.datascientist.path,
          title: CategoryCardTitles.datascientist.title,
        );
      case 'dataanalyst':
        return CategoryCard(
          image: Assets.icons.dataanalyst.path,
          title: CategoryCardTitles.dataanalyst.title,
        );
      case 'cybersecurity':
        return CategoryCard(
          image: Assets.icons.cybersecurity.path,
          title: CategoryCardTitles.cybersecurity.title,
        );
      case 'cplusplus':
        return CategoryCard(
          image: Assets.icons.cplusplus.path,
          title: CategoryCardTitles.cplusplus.title,
        );
      case 'backend':
        return CategoryCard(
          image: Assets.icons.backend.path,
          title: CategoryCardTitles.backend.title,
        );
      default:
        return null;
    }
  }
}
