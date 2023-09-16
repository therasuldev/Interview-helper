import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_prep/app_navigators.dart';
import 'package:interview_prep/core/provider/bloc/questions/question_bloc.dart';
import 'package:interview_prep/core/provider/bloc/questions/question_event.dart';
import 'package:interview_prep/core/provider/bloc/questions/question_state.dart';
import 'package:interview_prep/core/constant/screen_data_paths.dart';
import 'package:interview_prep/core/constant/categories.dart';
import 'package:interview_prep/core/constant/interview_categories.dart';
import 'package:interview_prep/view/pages/home/questions/questions.dart';

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
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            physics: const BouncingScrollPhysics(),
            itemCount: InterviewCategories.categories.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 1,
              mainAxisSpacing: 30,
            ),
          ),
        ),
      );
}
