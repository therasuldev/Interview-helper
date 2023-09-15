import 'package:flutter/material.dart';
import 'package:interview_prep/app_colors.dart';
import 'package:interview_prep/drawer_widget.dart';
import 'package:interview_prep/view/pages/home/home_categories_widget.dart';
import 'package:interview_prep/view/pages/library/library.dart';
import 'package:interview_prep/view/utils/utils.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final List<Widget> pages = [
    const HomeCategories(),
    const Library(),
  ];

  bottomTapped(index) {
    setState(() => pageIdx = index);
  }

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(pageIdx),
      body: pages.elementAt(pageIdx),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 16),
        unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 14),
        selectedItemColor: AppColors.appColor,
        currentIndex: pageIdx,
        onTap: (idx) => bottomTapped(idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Library'),
        ],
      ),
      drawer: pageIdx.isEqual(0) ? const DrawerWidget() : null,
    );
  }

  AppBar appBar(int pageIdx) => AppBar(
        title: Text(
          pageIdx.isEqual(0) ? 'Categories' : 'Library',
          style: ViewUtils.ubuntuStyle(fontSize: 22),
        ),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        elevation: 0,
      );
}

extension on int {
  bool isEqual(int value) {
    return this == value;
  }
}
