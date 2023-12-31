import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareApp {
  ShareApp._();
  static void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      //TODO: fix
      "",
      subject: '',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}