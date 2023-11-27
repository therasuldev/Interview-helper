import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_for_interview/src/config/router/app_route_const.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/questions/question_bloc.dart';

import '../../../utils/constants/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<QuestionBloc>(context);
    addQuestionsToCache();
  }

  late QuestionBloc bloc;
  String appBarTitle = '';

  void addQuestionsToCache() {
    for (var category in InterviewCategories.categories.toList()) {
      bloc.add(QuestionEvent.addQuestionsInitial(category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (!state.loading!) {
          context.goNamed(
            AppRouteConstant.questionsView,
            queryParameters: {"appBarTitle": appBarTitle},
            extra: state.questions,
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
                bloc.add(
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
}
