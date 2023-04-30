import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:go_router/go_router.dart';

class ProgrammingLanguageCategories extends StatefulWidget {
  const ProgrammingLanguageCategories({super.key});

  @override
  State<ProgrammingLanguageCategories> createState() =>
      _ProgrammingLanguageCategoriesState();
}

class _ProgrammingLanguageCategoriesState
    extends State<ProgrammingLanguageCategories> {
  /// programming lang. images
  final List<String> _images = [
    Assets.programmingLangPng.flutter.path,
    Assets.programmingLangPng.go.path,
  ];

  /// programming lang. names
  final List<String> _languages = [
    'Flutter',
    'Go lang',
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GridView.builder(
          itemCount: _languages.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (_, index) => _CategoriesBox(
            images: _images,
            languages: _languages,
            index: index,
          ),
        ),
      );
}

class _CategoriesBox extends StatelessWidget {
  _CategoriesBox(
      {required List<String> images,
      required List<String> languages,
      required int index})
      : _images = images,
        _languages = languages,
        _index = index;

  final List<String> _images;
  final List<String> _languages;
  final int _index;

  final _colors = [
    Colors.white,
    Colors.blueGrey[200]!,
  ];

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: () => context.go('/listv'),
          child: Container(
            alignment: Alignment.center,
            decoration: ViewUtils.categoryBox(
              colors: _colors,
              boxColor: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SizedBox(height: 100, child: Image.asset(_images[_index])),
                const Spacer(),
                Text(
                  _languages[_index],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.grey[600]!.withRed(50),
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
}
