import 'package:flutter/material.dart';
import 'package:interview_helper/gen/assets.gen.dart';

import '../../../utils/decorations/view_utils.dart';
import 'index.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Row(
              children: [
                const Spacer(),
                Transform.scale(
                  scale: 1.5,
                  child: Image.asset(
                    Assets.app.path,
                    color: Colors.grey.shade100,
                    colorBlendMode: BlendMode.difference,
                  ),
                ),
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
                MaterialPageRoute(builder: (_) => const SettingsView()),
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
                MaterialPageRoute(builder: (_) => const ContactUsScreen()),
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
    this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final leading = color != null ? Icon(icon, color: color) : Icon(icon);
    return ListTile(
      onTap: onTap,
      leading: leading,
      horizontalTitleGap: 20,
      title: Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
    );
  }

  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color? color;
}
