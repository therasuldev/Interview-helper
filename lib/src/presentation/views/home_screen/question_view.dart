import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/utils/index.dart';

import '../../../domain/models/index.dart';
import '../../widgets/index.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({
    super.key,
    required this.questions,
    required this.category,
    required this.index,
  });

  final List<Question> questions;
  final String category;
  final int index;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> with _QuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.loading!) return const SizedBox.shrink();
        final cachedQuestionsForCategory = state.questions ?? [];
        bool isSaved = cachedQuestionsForCategory.isSaved(questions[currentIndex]);
        return Scaffold(
          body: CustomScrollView(
            key: ValueKey(currentIndex),
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '${currentIndex + 1}/${questions.length}',
                      style: ViewUtils.ubuntuStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (isSaved) {
                        BlocProvider.of<CategoryBloc>(context).add(
                          CategoryEvent.removeBookmarkedQuestion(
                            widget.category,
                            questions[currentIndex],
                          ),
                        );
                      } else {
                        BlocProvider.of<CategoryBloc>(context).add(
                          CategoryEvent.bookmarkQuestionInitial(
                            widget.category,
                            questions[currentIndex],
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      Assets.svg.bookmark,
                      color: isSaved ? Colors.blue.shade200 : Colors.white,
                    ),
                  )
                ],
                pinned: true,
                backgroundColor: appBarColor,
                expandedHeight: MediaQuery.sizeOf(context).height * .5,
                flexibleSpace: _QuestionView(questions: questions, currentIndex: currentIndex),
              ),
              SliverToBoxAdapter(
                child: _AnswerView(
                  question: questions[currentIndex],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ChangeButton(child: 'previous', onPressed: _goToPreviousQuestion),
                _ChangeButton(child: 'next', onPressed: _goToNextQuestion),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({required this.questions, required this.currentIndex});

  final List<Question> questions;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: ClipPath(
        clipper: MyClipper(),
        child: ColoredBox(
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                questions[currentIndex].question,
                textAlign: TextAlign.center,
                style: ViewUtils.ubuntuStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerView extends StatelessWidget {
  const _AnswerView({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        question.answer,
        textAlign: TextAlign.justify,
        style: ViewUtils.ubuntuStyle(
          fontSize: 25,
          color: const Color.fromARGB(255, 89, 97, 107),
        ),
      ),
    );
  }
}

class _ChangeButton extends StatelessWidget {
  _ChangeButton({required this.child, required this.onPressed});

  final style = ViewUtils.ubuntuStyle(fontSize: 17, color: AppColors.primary);

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all(const BorderSide(color: AppColors.primary, strokeAlign: 10)),
        ),
        onPressed: onPressed,
        child: Text(child, style: style),
      );

  final String child;
  final VoidCallback onPressed;
}

mixin _QuestionViewMixin on State<QuestionView> {
  late int currentIndex;
  late List<Question> questions;
  late ScrollController _scrollController;

  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    questions = widget.questions;
    currentIndex = widget.index;

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 200) {
          setState(() => appBarColor = AppColors.primary);
        } else if (_scrollController.offset <= 200) {
          setState(() => appBarColor = Colors.transparent);
        }
      });

    BlocProvider.of<CategoryBloc>(context).add(
      CategoryEvent.fetchBookmarkedQuestionsForCategory(widget.category),
    );
  }

  void _goToNextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void _goToPreviousQuestion() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }
}

extension on List<Question> {
  bool isSaved(Question question) {
    return any((bq) => bq == question);
  }
}
