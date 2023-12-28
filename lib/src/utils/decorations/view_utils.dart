import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCardDecor() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade200),
        borderRadius: BorderRadius.circular(15),
      );

  //for question card [Questions page]
  static questionCardDecor() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      );

  // Ubuntu Google fonts
  static ubuntuStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
    return GoogleFonts.ubuntu(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  // App Snackbar
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showInterviewHelperSnackBar({
    required String snackbarTitle,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsetsDirectional.all(10),
      content: SizedBox(
        height: 35,
        child: Center(
          child: Text(
            snackbarTitle,
            style: ViewUtils.ubuntuStyle(fontSize: 16),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
