import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget? tralling;
  final Color iconColor;
  final Widget icon;
  final EdgeInsets margin;
  final Function()? onTap;

  const SettingTile({
    Key? key,
    required this.title,
    required this.iconColor,
    required this.icon,
    this.tralling,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
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
      padding: const EdgeInsets.all(10),
      child: Builder(builder: (context) {
        if (tralling == null) return mainPart();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [mainPart(), tralling!],
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

  Widget mainPart() {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: iconColor,
          ),
          child: Center(child: icon),
        ),
        const SizedBox(width: 10),
        Text(title, style: ViewUtils.ubuntuStyle(color: Colors.black)),
      ],
    );
  }
}
