import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:interview_helper/src/presentation/widgets/question_card.dart';
import 'package:interview_helper/src/utils/index.dart';

import '../../../domain/models/index.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({
    super.key,
    required this.questions,
    required this.category,
  });

  final List<Question> questions;
  final String? category;

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> with QuestionCardMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWithSearchSwitch(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return QuestionCard(
            questions: searchedList,
            category: widget.category!,
            index: index,
          );
        },
        padding: const EdgeInsets.only(top: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: searchedList.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
      ),
      backgroundColor: Colors.white,
    );
  }

  AppBarWithSearchSwitch _appBarWithSearchSwitch() {
    return AppBarWithSearchSwitch(
      onChanged: (input) {
        setState(() {});
        searchedList = widget.questions.where((v) {
          return v.question.contains(input.toLowerCase());
        }).toList();
      },
      appBarBuilder: (context) => AppBar(
        centerTitle: false,
        title: Text(widget.category ?? ''),
        actions: const [AppBarSearchButton()],
      ),
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: const TextStyle(),
    );
  }
}

mixin QuestionCardMixin on State<QuestionsView> {
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
}
