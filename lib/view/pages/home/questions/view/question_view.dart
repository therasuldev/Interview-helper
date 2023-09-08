import 'package:flutter/material.dart';
import 'package:interview_prep/app_colors.dart';
import 'package:interview_prep/appbar_clipper.dart';
import 'package:interview_prep/core/model/question/question.dart';
import 'package:interview_prep/view/utils/utils.dart';

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

class _QuestionViewState extends State<QuestionView> {
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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(240),
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 300,
              color: AppColors.appColor,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      children: [
                        const BackButton(color: Colors.white),
                        const Spacer(),
                        Text(
                          '${currentIndex + 1}/${widget.questions.length}',
                          style: ViewUtils.ubuntuStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
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
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * .2,
            left: 5,
            right: 5,
            top: 5,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              questions[currentIndex].answer,
              textAlign: TextAlign.center,
              style: ViewUtils.ubuntuStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 89, 97, 107),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CustomFloatingActionButton(
                heroTag: 'previous',
                label: 'previous',
                onPressed: _goToPreviousQuestion,
              ),
              _CustomFloatingActionButton(
                heroTag: 'next',
                label: 'next',
                onPressed: _goToNextQuestion,
              ),
            ],
          ),
        ),
      );
}

class _CustomFloatingActionButton extends StatelessWidget {
  _CustomFloatingActionButton({
    required this.heroTag,
    required this.label,
    required this.onPressed,
  });

  final style = ViewUtils.ubuntuStyle(fontSize: 17, color: AppColors.appColor);

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        elevation: 0,
        heroTag: heroTag,
        onPressed: onPressed,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        label: Text(label, style: style),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.appColor),
        ),
      );

  final String heroTag;
  final String label;
  final void Function()? onPressed;
}
