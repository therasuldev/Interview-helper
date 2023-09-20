import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_prep/src/config/router/app_navigators.dart';
import 'package:interview_prep/src/presentation/provider/bloc/questions/question_bloc.dart';
import 'package:interview_prep/src/presentation/views/home_screen/questions_view.dart';
import 'package:interview_prep/src/utils/constants/categories.dart';
import 'package:interview_prep/src/utils/constants/interview_categories.dart';
import 'package:interview_prep/src/utils/constants/screen_data_paths.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              QuestionsView(
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
              final card = CategoryHelper().cards(ScreenDataPaths().homeCategoryPathNames[index]);
              return GestureDetector(
                onTap: () {
                  _bloc.add(
                    QuestionEvent.fetchQuestionStart(
                      InterviewCategories.categories.toList()[index],
                    ),
                  );
                  setState(() => appBarTitle = card!.title);
                },
                child: card,
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
