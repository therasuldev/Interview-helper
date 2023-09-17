import 'package:flutter/material.dart';
import 'package:interview_prep/src/utils/constants/app_colors.dart';
import 'package:interview_prep/src/presentation/views/drawer_screen/drawer_view.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

class InterviewPrepScaffold extends StatefulWidget {
  const InterviewPrepScaffold({super.key, required this.screens});
  final List<Widget> screens;

  @override
  State<InterviewPrepScaffold> createState() => _InterviewPrepScaffoldState();
}

class _InterviewPrepScaffoldState extends State<InterviewPrepScaffold> {
  changeScreen(index) {
    setState(() => screenIndex = index);
  }

  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(screenIndex),
      body: widget.screens.elementAtOrNull(screenIndex),
      drawer: screenIndex.isEqual(0) ? const DrawerWidget() : null,
      bottomNavigationBar: _BottomNavBar(screenIndex: screenIndex, changeScreen: changeScreen),
    );
  }

  AppBar appBar(int screenIndex) => AppBar(
        title: Text(
          screenIndex.isEqual(0) ? 'Categories' : 'Library',
          style: ViewUtils.ubuntuStyle(fontSize: 22),
        ),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        elevation: 0,
      );
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.screenIndex, required this.changeScreen});

  final ValueChanged changeScreen;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _buildItems,
      currentIndex: screenIndex,
      selectedItemColor: AppColors.appColor,
      onTap: (index) => changeScreen.call(index),
      selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 16),
      unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 14),
    );
  }

  List<BottomNavigationBarItem> get _buildItems {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Library'),
    ];
  }
}

extension on int {
  bool isEqual(int value) {
    return this == value;
  }
}
