import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/pages/categories/categories.dart';
import 'package:flutter_interview_questions/view/pages/store/store.dart';
import 'package:kartal/kartal.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final List<Widget> _children = [
    const LangCategories(),
    const BookStore(),
  ];

  _bottomTapped(index) {
    setState(() {
      this.index = index;
    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAtOrNull(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (ind) => _bottomTapped(ind),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: '')
        ],
      ),
    );
  }
}
