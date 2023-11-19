import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget? tralling;
  final Color iconColor;
  final Widget icon;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  const SettingTile({
    Key? key,
    required this.title,
    required this.iconColor,
    required this.icon,
    this.tralling,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: margin, child: card());
  }

  Widget card() {
    var body = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.1))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Builder(builder: (context) {
        return _MainPart(
          iconColor: iconColor,
          tralling: tralling,
          title: title,
          icon: icon,
        );
      }),
    );

    if (onTap == null) return body;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: body,
    );
  }
}

class _MainPart extends StatelessWidget {
  const _MainPart({
    required this.iconColor,
    required this.icon,
    required this.title,
    this.tralling,
  });

  final Color iconColor;
  final Widget icon;
  final String title;
  final Widget? tralling;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 30,
        width: 30,
        child: icon,
      ),
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      trailing: tralling ?? const SizedBox.shrink(),
      title: Text(title, style: ViewUtils.ubuntuStyle(color: Colors.black)),
    );
  }
}
