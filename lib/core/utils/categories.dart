import 'package:flutter_interview_questions/core/app/enum/lang_title_enum.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/pages/categories/category_card.dart';

class CategoryHelper {
  CategoryCard? cards(String name) {
    switch (name) {
      case 'flutter':
        return CategoryCard(
          image: Assets.programmingLangPng.flutter.path,
          title: Titles.flutter.title,
        );

      case 'go':
        return CategoryCard(
          image: Assets.programmingLangPng.go.path,
          title: Titles.go.title,
        );
      case 'java':
        return CategoryCard(
          image: Assets.programmingLangPng.java.path,
          title: Titles.java.title,
        );
      case 'python':
        return CategoryCard(
          image: Assets.programmingLangPng.python.path,
          title: Titles.python.title,
        );
      case 'ruby':
        return CategoryCard(
          image: Assets.programmingLangPng.ruby.path,
          title: Titles.ruby.title,
        );
      case 'rust':
        return CategoryCard(
          image: Assets.programmingLangPng.rust.path,
          title: Titles.rust.title,
        );
      case 'js':
        return CategoryCard(
          image: Assets.programmingLangPng.js.path,
          title: Titles.js.title,
        );
      case 'react':
        return CategoryCard(
          image: Assets.programmingLangPng.react.path,
          title: Titles.react.title,
        );
      case 'csharp':
        return CategoryCard(
          image: Assets.programmingLangPng.csharp.path,
          title: Titles.csharp.title,
        );
      default:
        return null;
    }
  }
}
