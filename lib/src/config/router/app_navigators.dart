import 'package:flutter/material.dart';

class AppNavigators {
  static PageRouteBuilder opaquePage(Widget page, [RouteSettings? settings]) =>
      PageRouteBuilder(
        opaque: false,
        settings: settings,
        pageBuilder: (BuildContext context, _, __) => page,
      );

  static go(BuildContext context, Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  static goAndRmUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
