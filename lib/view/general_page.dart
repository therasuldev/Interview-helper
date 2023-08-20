import 'package:flutter/material.dart';

import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/settings.dart';
import 'package:flutter_interview_questions/view/pages/home/categories.dart';
import 'package:flutter_interview_questions/view/pages/library/library.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

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
        drawer: const _DrawerWidget(),
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

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                const Spacer(),
                Image.asset(Assets.splash.path),
                const Spacer(),
              ],
            ),
          ),
          _ListTile(
            icon: Icons.star_border,
            color: Colors.yellow,
            title: 'Rate us',
            onTap: () {},
          ),
          _ListTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Settings()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    Key? key,
    this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final leadingW = color != null ? Icon(icon, color: color) : Icon(icon);
    return ListTile(
      onTap: onTap,
      leading: leadingW,
      horizontalTitleGap: 0,
      title: Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
    );
  }
}
