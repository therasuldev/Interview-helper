import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'src/presentation/views/drawer_screen/index.dart';
import 'src/utils/index.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.body});
  final StatefulNavigationShell body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  void goBranch(index) => widget.body.goBranch(
        index,
        initialLocation: index == widget.body.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.body.currentIndex),
      backgroundColor: Colors.white,
      body: widget.body,
      drawer: widget.body.currentIndex.isEqual(0) ? const DrawerView() : null,
      bottomNavigationBar: _BottomNavBar(changeScreen: goBranch, screenIndex: widget.body.currentIndex),
    );
  }

  AppBar appBar(int screenIndex) {
    return AppBar(
      title: Text(screenIndex.isEqual(0) ? 'Categories' : 'Library'),
      centerTitle: true,
      elevation: 0,
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.screenIndex, required this.changeScreen});

  final ValueChanged changeScreen;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _buildItems,
      onTap: changeScreen,
      currentIndex: screenIndex,
      selectedItemColor: AppColors.primary,
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
  bool isEqual(int value) => this == value;
}
