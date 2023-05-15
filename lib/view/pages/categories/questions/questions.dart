import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/question/question.dart';
import 'package:flutter_interview_questions/view/pages/categories/questions/view/question_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:kartal/kartal.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<Questions> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<Questions> {
  final searchBarController = TextEditingController();

  List<Question> searchedList = [];

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
      appBar: appBarBuild(),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        shrinkWrap: true,
        itemCount: searchedList.length,
        itemBuilder: (context, index) {
          final question = searchedList[index];
          return _QuestionCard(
            questions: searchedList,
            question: question,
            index: index,
          );
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  AppBar appBarBuild() => AppBar(
        title: SearchBar(
          trailing: [
            CloseButton(color: Colors.black, onPressed: clearSearchBar)
          ],
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: (input) {
            setState(() {});
            searchedList = widget.questions.where((q) {
              return q.question.contains(input.toLowerCase());
            }).toList();
          },
          hintText: 'search question..',
          controller: searchBarController,
          elevation: MaterialStateProperty.all(0),
          leading: const BackButton(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
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
      height: 100,
      width: context.width * .8,
      decoration: ViewUtils.questionCard(),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
