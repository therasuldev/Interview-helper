import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_state.dart';
import 'package:flutter_interview_questions/core/utils/all_lang.dart';
import 'package:flutter_interview_questions/core/utils/categories.dart';
import 'package:flutter_interview_questions/core/utils/categories_list.dart';
import 'package:flutter_interview_questions/view/pages/categories/questions/questions.dart';

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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
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
                    Categories.categories.current(index),
                  ),
                ),
                child: CategoryHelper().cards(AllLanguages.all[index]),
              );
            },
            itemCount: Categories.categories.length,
          ),
        ),
      );
}

extension _CurrentIndex on List {
  current(int index) {
    return this[indexWhere((val) => val == AllLanguages.all[index])];
  }
}
