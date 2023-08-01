import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/view/pages/home/questions/view/question_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class Questions extends StatefulWidget {
  const Questions(
      {super.key, required this.questions, required this.appBarTitle});

  final List<Question> questions;
  final String appBarTitle;

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

  void clearSearchBar() {
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
            widget.appBarTitle,
            style: ViewUtils.ubuntuStyle(fontSize: 22),
          ),
          centerTitle: true,
          actions: const [AppBarSearchButton()],
          backgroundColor: const Color.fromARGB(255, 38, 109, 176),
        ),
        backgroundColor: const Color.fromARGB(255, 38, 109, 176),
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
      decoration: ViewUtils.questionCardDecor(),
      margin: const EdgeInsets.all(7),
      child: ListTile(
        onTap: () => AppNavigators.go(
          context,
          QuestionView(questions: questions, index: index),
        ),
        title: Text(
          '${index + 1}. ${question.question}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ViewUtils.ubuntuStyle(fontSize: 20, color: Colors.black),
        ),
        subtitle: Text(' ${question.answer}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ViewUtils.ubuntuStyle(fontSize: 18, color: Colors.grey)),
      ),
    );
  }
}
