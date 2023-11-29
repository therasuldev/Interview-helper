import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../widgets/widgets.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key, required this.questions, required this.index});

  final List<Question> questions;
  final int index;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> with _QuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        key: ValueKey(currentIndex),
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
              )
            ],
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
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
            _ChangeButton(childText: 'previous', onPressed: _goToPreviousQuestion),
            _ChangeButton(childText: 'next', onPressed: _goToNextQuestion),
          ],
        ),
      ),
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
        child: Container(
          height: 300,
          color: AppColors.appColor,
          alignment: Alignment.center,
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
    );
  }
}

class _AnswerView extends StatelessWidget {
  const _AnswerView({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question.answer,
      textAlign: TextAlign.center,
      style: ViewUtils.ubuntuStyle(
        fontSize: 25,
        color: const Color.fromARGB(255, 89, 97, 107),
      ),
    );
  }
}

class _ChangeButton extends StatelessWidget {
  _ChangeButton({required this.childText, required this.onPressed});

  final style = ViewUtils.ubuntuStyle(fontSize: 17, color: AppColors.appColor);

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all(const BorderSide(color: AppColors.appColor, strokeAlign: 10)),
        ),
        onPressed: onPressed,
        child: Text(childText, style: style),
      );

  final String childText;
  final VoidCallback onPressed;
}

mixin _QuestionViewMixin on State<QuestionView> {
  late List<Question> questions;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    questions = widget.questions;
    currentIndex = widget.index;
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
