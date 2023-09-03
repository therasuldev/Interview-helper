import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/contact_us_screen.dart';

import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/settings.dart';
import 'package:flutter_interview_questions/view/pages/home/home_categories_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: pageIdx.isEqual(0) ? const _Drawer() : null,
    );
  }

  AppBar appBar(int pageIdx) => AppBar(
        title: Text(
          pageIdx.isEqual(0) ? 'Categories' : 'Library',
          style: ViewUtils.ubuntuStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 38, 109, 176),
      );
}

class _Drawer extends StatelessWidget {
  const _Drawer();

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
          const SizedBox(height: 50),
          _ListTile(
            icon: Icons.star_border_outlined,
            color: Colors.yellow.shade800,
            title: 'Rate us',
            onTap: () {
              // TODO: Rate app feature
              // showDialog(
              //   context: context,
              //   builder: (context) => RateApp.ratingDialog(context),
              // );
            },
          ),
          _ListTile(
            icon: Icons.share_outlined,
            color: Colors.black,
            title: 'Share',
            onTap: () {
              //TODO: share app feature
              //ShareApp.onShare(context);
            },
          ),
          _ListTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Settings()),
              );
            },
          ),
          _ListTile(
            icon: Icons.send,
            title: 'Contact us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ContactUsScreen()),
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

extension on int {
  bool isEqual(int value) {
    return this == value;
  }
}
