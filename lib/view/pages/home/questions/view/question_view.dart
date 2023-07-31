import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/appbar_clipper.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';

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

  _goToNextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    }
  }

  _goToPreviousQuestion() {
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
              color: const Color.fromARGB(255, 38, 109, 176),
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
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    questions[currentIndex].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 5,
            bottom: MediaQuery.of(context).size.width * .2,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              questions[currentIndex].answer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 89, 97, 107),
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
  const _CustomFloatingActionButton({
    required this.heroTag,
    required this.label,
    required this.onPressed,
  });

  final style = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: Colors.green[500],
        label: Text(label, style: style),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );

  final String heroTag;
  final String label;
  final void Function()? onPressed;
}
