import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          return _QuestionCard(
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

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.questions,
    required this.category,
    required this.index,
  });

  final List<Question> questions;
  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * .8,
      decoration: ViewUtils.questionCardDecor(),
      margin: const EdgeInsets.all(7),
      child: ListTile(
        onTap: () {
          context.pushNamed(
            AppRouteConstant.questionView,
            queryParameters: {'index': index.toString(), "category": category},
            extra: questions,
          );
        },
        title: Text(
          '${index + 1}. ${questions[index].question}',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: ViewUtils.ubuntuStyle(fontSize: 20, color: Colors.black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            questions[index].answer,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: ViewUtils.ubuntuStyle(
              fontSize: 18,
              color: Colors.blueGrey.withOpacity(.6).withBlue(155),
            ),
          ),
        ),
        isThreeLine: true,
      ),
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
