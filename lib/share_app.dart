import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareApp {
  ShareApp._();
  static void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      //TODO: fix
      "https://play.google.com/store/apps/details?id=com.riddle.game.en",
      subject: '',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}