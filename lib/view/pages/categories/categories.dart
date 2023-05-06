import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_state.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/pages/questions/questions.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class LangCategories extends StatefulWidget {
  const LangCategories({super.key});

  @override
  State<LangCategories> createState() => _LangCategoriesState();
}

class _LangCategoriesState extends State<LangCategories> {
  /// programming lang. images
  final List<String> _images = [
    Assets.programmingLangPng.flutter.path,
    Assets.programmingLangPng.go.path,
  ];

  /// programming lang.
  final List<String> _languages = [
    'Flutter',
    'Go lang',
  ];

  final List<String> categories = [
    'flutter',
    'go',
  ];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuestionBloc>(context);
  }

  late QuestionBloc _bloc;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<QuestionBloc, QuestionState>(
          listener: (context, state) {
            if (!state.loading!) {
              AppNavigators.go(
                context,
                Questions(questions: state.questions ?? []),
              );
            }
          },
          child: GridView.builder(
            itemCount: _languages.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 1,
              mainAxisSpacing: 30,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _bloc.add(
                QuestionEvent.fetchQuestionStart(categories[index]),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: ViewUtils.categoryCard(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(height: 100, child: Image.asset(_images[index])),
                    const Spacer(),
                    Text(
                      _languages[index],
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
          ),
        ),
      );
}
