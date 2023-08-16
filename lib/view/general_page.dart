import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/pages/home/categories.dart';
import 'package:flutter_interview_questions/view/pages/library/library.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final List<Widget> pages = List.unmodifiable([
    const HomeCategories(),
    const Library(),
  ]);

  bottomTapped(index) {
    setState(() => pageIdx = index);
  }

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: appBar(pageIdx),
        body: pages.elementAt(pageIdx),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 16),
          unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 14),
          selectedItemColor: const Color.fromARGB(255, 38, 109, 176),
          currentIndex: pageIdx,
          onTap: (idx) => bottomTapped(idx),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories), label: 'Library'),
          ],
        ),
      );

  AppBar appBar(int pageIdx) {
    return AppBar(
      centerTitle: true,
      title: Text(
        pageIdx == 0 ? 'Categories' : 'Library',
        style: ViewUtils.ubuntuStyle(fontSize: 22),
      ),
      backgroundColor: const Color.fromARGB(255, 38, 109, 176),
    );
  }
}
