import 'package:flutter/material.dart';
import 'package:interview_prep/src/utils/constants/app_colors.dart';
import 'package:interview_prep/src/presentation/widgets/appbar_clipper.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({
    super.key,
    required this.questions,
    required this.index,
  });

  final List<Question> questions;
  final int index;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> with _QuestionViewMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(240),
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 300,
              color: AppColors.appColor,
              alignment: Alignment.center,
              child: _QuestionViewModel(currentIndex: currentIndex, questions: questions),
            ),
          ),
        ),
        body: _AnswerViewModel(question: questions[currentIndex]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActionButton(childText: 'previous', onPressed: _goToPreviousQuestion),
              _ActionButton(childText: 'next', onPressed: _goToNextQuestion),
            ],
          ),
        ),
      );
}

class _QuestionViewModel extends StatelessWidget {
  const _QuestionViewModel({
    required this.currentIndex,
    required this.questions,
  });

  final int currentIndex;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 15),
          child: Row(
            children: [
              const BackButton(color: Colors.white),
              const Spacer(),
              Text(
                '${currentIndex + 1}/${questions.length}',
                style: ViewUtils.ubuntuStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
        Text(
          questions[currentIndex].question,
          textAlign: TextAlign.center,
          style: ViewUtils.ubuntuStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}

class _AnswerViewModel extends StatelessWidget {
  const _AnswerViewModel({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .2, left: 5, right: 5, top: 5),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          question.answer,
          textAlign: TextAlign.center,
          style: ViewUtils.ubuntuStyle(
            fontSize: 25,
            color: const Color.fromARGB(255, 89, 97, 107),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  _ActionButton({
    required this.childText,
    required this.onPressed,
  });

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
