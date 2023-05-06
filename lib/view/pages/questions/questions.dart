import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/view/pages/view/question_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:kartal/kartal.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<Questions> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<Questions> {
  final textController = TextEditingController();
  final fieldFocusNode = FocusNode();
  final boxController = BoxController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        boxController.close?.call();
        fieldFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FieldSuggestion(
            boxController: boxController,
            focusNode: fieldFocusNode,
            boxStyle: _boxStyle(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  await AppNavigators.go(
                    context,
                    QuestionView(questions: widget.questions, index: index),
                  );
                },
                leading: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey.shade800,
                  ),
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                subtitle: const Divider(thickness: 1, color: Colors.black),
                title: HighlightText(
                  widget.questions[index].question,
                  highlight: Highlight(words: [textController.text]),
                  caseSensitive: true,
                  detectWords: true,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  highlightStyle: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 2.5,
                    color: Colors.black,
                    backgroundColor: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            inputDecoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: UnderlineInputBorder(),
              hintStyle: TextStyle(fontStyle: FontStyle.italic),
              hintText: 'search question...',
            ),
            textController: textController,
            suggestions: widget.questions,
            search: (item, input) => item.question.contains(input),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          shrinkWrap: true,
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            final question = widget.questions[index];
            return _QuestionCard(
              questions: widget.questions,
              question: question,
              index: index,
            );
          },
        ),
      ),
    );
  }

  BoxStyle _boxStyle() => BoxStyle(
        backgroundColor: Colors.blueGrey.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      );
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.questions,
    required this.question,
    required this.index,
  });

  final List<Question> questions;
  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: context.width * .8,
      height: 100,
      decoration: ViewUtils.questionCard(),
      child: ListTile(
        onTap: () => AppNavigators.go(
          context,
          QuestionView(questions: questions, index: index),
        ),
        title: Text(
          '${index + 1}. ${question.question}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          ' ${question.answer}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
