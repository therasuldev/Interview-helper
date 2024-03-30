import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/src/data/datasources/local/application_lang.dart';
import 'package:interview_helper/src/presentation/provider/bloc/questions/question_bloc.dart';
import 'package:interview_helper/src/utils/index.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addQuestionsToCache();
  }

  void addQuestionsToCache() async {
    for (var category in InterviewCategories.categories.toList()) {
      _bloc.add(QuestionEvent.addQuestionsInitial(category, context.locale.languageCode));
    }
  }

  String category = '';
  late QuestionBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (!state.loading!) {
          context.goNamed(
            AppRouteConstant.questionsView,
            queryParameters: {"category": category},
            extra: state.questions,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView.builder(
          itemBuilder: (context, index) {
            final card = CategoryCards.cards(CategoryTitles.homeCategory[index]);
            return GestureDetector(
              onTap: () async {
                _bloc.add(
                  QuestionEvent.fetchQuestionStart(
                    InterviewCategories.categories.toList()[index],
                    context.locale.languageCode,
                  ),
                );
                setState(() => category = card!.category);
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
