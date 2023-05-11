import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_state.dart';
import 'package:flutter_interview_questions/core/utils/categories.dart';
import 'package:flutter_interview_questions/view/pages/categories/questions/questions.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class LangCategories extends StatefulWidget {
  const LangCategories({super.key});

  @override
  State<LangCategories> createState() => _LangCategoriesState();
}

class _LangCategoriesState extends State<LangCategories> {
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuestionBloc>(context);
  }

  late QuestionBloc _bloc;

  @override
  Widget build(BuildContext context) =>
      BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (!state.loading!) {
            AppNavigators.go(
              context,
              Questions(questions: state.questions ?? []),
            );
          }
        },
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _bloc.add(
                QuestionEvent.fetchQuestionStart(
                  Categories.categories[index],
                ),
              ),
              child: _CategoryCard(
                image: Categories.images[index],
                language: Categories.names[index],
              ),
            );
          },
          itemCount: Categories.categories.length,
        ),
      );
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.image, required this.language});

  final String image;
  final String language;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: ViewUtils.categoryCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(height: 100, child: Image.asset(image)),
            const Spacer(),
            Text(
              language,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.grey[600]!.withRed(50),
                  fontWeight: FontWeight.w900),
            ),
            const Spacer(),
          ],
        ),
      );
}
