import 'package:flutter_interview_questions/core/app/enum/lang_title_enum.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/pages/home/category_card.dart';

class CategoryHelper {
  CategoryCard? cards(String name) {
    switch (name) {
      case 'flutter':
        return CategoryCard(
          image: Assets.imageData.flutter.path,
          title: Titles.flutter.title,
        );

      case 'go':
        return CategoryCard(
          image: Assets.imageData.go.path,
          title: Titles.go.title,
        );
      case 'java':
        return CategoryCard(
          image: Assets.imageData.java.path,
          title: Titles.java.title,
        );
      case 'python':
        return CategoryCard(
          image: Assets.imageData.python.path,
          title: Titles.python.title,
        );
      case 'ruby':
        return CategoryCard(
          image: Assets.imageData.ruby.path,
          title: Titles.ruby.title,
        );
      case 'rust':
        return CategoryCard(
          image: Assets.imageData.rust.path,
          title: Titles.rust.title,
        );
      case 'js':
        return CategoryCard(
          image: Assets.imageData.js.path,
          title: Titles.js.title,
        );
      case 'react':
        return CategoryCard(
          image: Assets.imageData.react.path,
          title: Titles.react.title,
        );
      case 'csharp':
        return CategoryCard(
          image: Assets.imageData.csharp.path,
          title: Titles.csharp.title,
        );
      case 'nodejs':
        return CategoryCard(
          image: Assets.imageData.nodejs.path,
          title: Titles.nodejs.title,
        );
      case 'perl':
        return CategoryCard(
          image: Assets.imageData.perl.path,
          title: Titles.perl.title,
        );
      case 'php':
        return CategoryCard(
          image: Assets.imageData.php.path,
          title: Titles.php.title,
        );
      case 'scala':
        return CategoryCard(
          image: Assets.imageData.scala.path,
          title: Titles.scala.title,
        );
      case 'swift':
        return CategoryCard(
          image: Assets.imageData.swift.path,
          title: Titles.swift.title,
        );
      case 'git':
        return CategoryCard(
          image: Assets.imageData.git.path,
          title: Titles.git.title,
        );
      case 'frontend':
        return CategoryCard(
          image: Assets.imageData.frontend.path,
          title: Titles.frontend.title,
        );
      case 'engineer':
        return CategoryCard(
          image: Assets.imageData.engineer.path,
          title: Titles.engineer.title,
        );
      case 'datascientist':
        return CategoryCard(
          image: Assets.imageData.datascientist.path,
          title: Titles.datascientist.title,
        );
      case 'dataanalyst':
        return CategoryCard(
          image: Assets.imageData.dataanalyst.path,
          title: Titles.dataanalyst.title,
        );
      case 'cybersecurity':
        return CategoryCard(
          image: Assets.imageData.cybersecurity.path,
          title: Titles.cybersecurity.title,
        );
      case 'cplasplas':
        return CategoryCard(
          image: Assets.imageData.cplasplas.path,
          title: Titles.cplasplas.title,
        );
      case 'backend':
        return CategoryCard(
          image: Assets.imageData.backend.path,
          title: Titles.backend.title,
        );
      default:
        return null;
    }
  }
}
