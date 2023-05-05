import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/view/pages/view/question_view.dart';
import 'package:kartal/kartal.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<QuestionListView> createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [Icon(Icons.search)],
          title: FieldSuggestion(
            boxStyle: const BoxStyle(backgroundColor: Colors.red),
            itemBuilder: (_, i) {
              return Container(color: Colors.red, child: const Text('salam'));
            },
            textController: textController,
            suggestions: widget.questions,
            search: (item, input) {
              return true;
            },
          ),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.questions.length,
            itemBuilder: (context, index) {
              final question = widget.questions[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: context.width * .8,
                height: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      offset: const Offset(0, 5),
                      spreadRadius: .5,
                      blurRadius: 2,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.blue.shade50,
                    ],
                    stops: const [0.3, 1],
                  ),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    AppNavigators.go(
                      context,
                      QuestionView(
                        questions: widget.questions,
                        index: index,
                      ),
                    );
                  },
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
            }),
      );
}
