import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({super.key});

  @override
  State<QuestionListView> createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (context, index) => _QuestionBox(index: index),
        ),
      );
}

class _QuestionBox extends StatelessWidget {
  const _QuestionBox({required int index}) : _index = index;

  final int _index;

  @override
  Widget build(BuildContext context) {
    //decoration local variable
    final boxDecoration = BoxDecoration(
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
        colors: [Colors.white,Colors.blue.shade50],
        stops: const [0.3, 1],
      ),
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    );

    ///
    //  build widget
    ///
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: context.width * .8,
      height: 100,
      decoration: boxDecoration,
      child: ListTile(
        onTap: () {
          context.go('/listv/b');
        },
        title: Text(
          '${_index + 1}. To switch to a new route, use the Navigator. push() method. The push() method ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: const Text(
          'To switch to a new route, use the Navigator. push() method. The push() method adds a Route to the stack of routes managed by the Navigator . The pop() method removes the current Route from the stack of routes managed by the Navigator.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
