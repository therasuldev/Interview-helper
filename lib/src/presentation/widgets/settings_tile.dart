import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/view_utils.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget? tralling;
  final Color iconColor;
  final Widget icon;
  final EdgeInsets margin;
  final VoidCallback? onTap;
  final bool? showLangCode;

  const SettingTile({
    super.key,
    required this.title,
    required this.iconColor,
    required this.icon,
    this.showLangCode = false,
    this.tralling,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.onTap,
  });

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
          showLangCode: showLangCode ?? false,
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
    required this.showLangCode,
    this.tralling,
  });

  final Color iconColor;
  final Widget icon;
  final String title;
  final Widget? tralling;
  final bool showLangCode;

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
      title: showLangCode
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: ViewUtils.ubuntuStyle(color: Colors.black)),
                context.locale.languageCode.getCountryFlag(),
              ],
            )
          : Text(title, style: ViewUtils.ubuntuStyle(color: Colors.black)),
    );
  }
}

extension on String {
  Widget getCountryFlag() {
    const style = TextStyle(fontSize: 20);
    final flag = switch (this) {
      'en' => const Text('🇬🇧', style: style),
      'ru' => const Text('🇷🇺', style: style),
      'tr' => const Text('🇹🇷', style: style),
      _ => const SizedBox.shrink(),
    };
    return flag;
  }
}
