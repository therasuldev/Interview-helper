import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_helper/gen/assets.gen.dart';

import '../../../utils/view_utils.dart';
import 'index.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
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
            title: 'drawer.rateUs'.tr(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ViewUtils.ratingDialog(context);
                },
              );
            },
          ),
          _ListTile(
            icon: Icons.share_outlined,
            color: Colors.black,
            title: 'drawer.share'.tr(),
            onTap: () => ViewUtils.onShare(context),
          ),
          _ListTile(
            icon: Icons.settings_outlined,
            color: Colors.grey,
            title: 'drawer.settings'.tr(),
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
            title: 'drawer.contactUs'.tr(),
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
  final VoidCallback onTap;
  final Color? color;
}
