import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/pages/categories/categories.dart';
import 'package:flutter_interview_questions/view/pages/store/store.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Programming languages',
            style:
                GoogleFonts.ubuntu(fontWeight: FontWeight.w400, fontSize: 22),
          ),
          backgroundColor: const Color.fromARGB(255, 38, 109, 176),
        ),
        body: _children.elementAtOrNull(index),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle:
              GoogleFonts.ubuntu(fontWeight: FontWeight.w400, fontSize: 16),
          selectedItemColor: const Color.fromARGB(255, 38, 109, 176),
          currentIndex: index,
          onTap: (ind) => _bottomTapped(ind),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories), label: 'Library'),
          ],
        ),
      );
}
