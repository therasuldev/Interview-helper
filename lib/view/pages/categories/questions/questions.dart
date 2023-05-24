import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/view/pages/categories/questions/view/question_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<Questions> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<Questions> {
  final searchBarController = TextEditingController();

  late List<Question> searchedList;

  @override
  void initState() {
    super.initState();
    searchedList = widget.questions;
  }

  clearSearchBar() {
    searchBarController.clear();
    searchedList = widget.questions;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (input) {
          setState(() {});
          searchedList = widget.questions.where((v) {
            return v.question.contains(input.toLowerCase());
          }).toList();
        },
        appBarBuilder: (context) => AppBar(
          title: Text(
            'Questions',
            style: ViewUtils.ubuntuStyle(),
          ),
          actions: const [AppBarSearchButton()],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: searchedList.length,
        itemBuilder: (context, index) {
          final question = searchedList[index];
          return _QuestionCard(
            questions: searchedList,
            question: question,
            index: index,
          );
        },
        shrinkWrap: true,
      ),
      backgroundColor: Colors.grey[200],
    );
  }
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
      height: 100,
      width: MediaQuery.of(context).size.width * .8,
      decoration: ViewUtils.questionCard(),
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
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
