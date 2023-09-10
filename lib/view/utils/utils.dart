import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCardDecor() => BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.blueGrey.shade200),
        borderRadius: BorderRadius.circular(15),
      );

  //for question card [Questions page]
  static questionCardDecor() => BoxDecoration(
        color: Colors.grey[200],
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
}
