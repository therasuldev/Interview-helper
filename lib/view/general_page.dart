import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/pages/categories/categories.dart';
import 'package:flutter_interview_questions/view/pages/store/store.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

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
        backgroundColor: Colors.grey[200],
        appBar: index == 0 ? _homeAppBar() : null,
        body: _children.elementAtOrNull(index),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 16),
          unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 14),
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

  AppBar _homeAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Programming languages',
        style: ViewUtils.ubuntuStyle(fontSize: 22),
      ),
      backgroundColor: const Color.fromARGB(255, 38, 109, 176),
    );
  }

  AppBar _libraryAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Library',
        style: ViewUtils.ubuntuStyle(fontSize: 22),
      ),
      backgroundColor: const Color.fromARGB(255, 38, 109, 176),
    );
  }
}
