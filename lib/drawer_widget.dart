import 'package:flutter/material.dart';
import 'package:interview_prep/contact_us_screen.dart';
import 'package:interview_prep/gen/assets.gen.dart';
import 'package:interview_prep/settings.dart';
import 'package:interview_prep/view/utils/utils.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                const Spacer(),
                Image.asset(Assets.app.path),
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
            onTap: () async {
              //TODO: share app feature
              //ShareApp.onShare(context);
            },
          ),
          _ListTile(
            icon: Icons.settings_outlined,
            color: Colors.grey,
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
            color: Colors.green,
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

  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color? color;
}
