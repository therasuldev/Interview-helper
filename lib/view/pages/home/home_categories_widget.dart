import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_event.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_state.dart';
import 'package:flutter_interview_questions/core/constant/screen_data_paths.dart';
import 'package:flutter_interview_questions/core/constant/categories.dart';
import 'package:flutter_interview_questions/core/constant/interview_categories.dart';
import 'package:flutter_interview_questions/view/pages/home/questions/questions.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<QuestionBloc>(context);
  }

  late QuestionBloc _bloc;
  String appBarTitle = '';

  @override
  Widget build(BuildContext context) =>
      BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (!state.loading!) {
            AppNavigators.go(
              context,
              Questions(
                appBarTitle: appBarTitle,
                questions: state.questions ?? [],
              ),
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
              final cards = CategoryHelper().cards(ScreenDataPaths().homeCategoryPathNames[index]);
              return GestureDetector(
                onTap: () {
                  _bloc.add(
                    QuestionEvent.fetchQuestionStart(
                      InterviewCategories.categories.toList()[index],
                    ),
                  );
                  setState(() => appBarTitle = cards!.title);
                },
                child: cards,
              );
            },
            itemCount: InterviewCategories.categories.length,
          ),
        ),
      );
}
