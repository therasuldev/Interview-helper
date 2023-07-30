import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCardDecor() => BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600]!,
            offset: const Offset(-10, -10),
            blurRadius: 10,
            spreadRadius: -10,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(10, 10),
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      );

  //for question card [Questions page]
  static questionCardDecor() => BoxDecoration(
      color: Colors.grey[200],
      boxShadow: [
        BoxShadow(
          color: Colors.grey[600]!,
          offset: const Offset(-10, -10),
          blurRadius: 10,
          spreadRadius: -11,
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(10, 10),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
      borderRadius: BorderRadius.circular(10));

  // Ubuntu Google fonts
  static ubuntuStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
    return GoogleFonts.ubuntu(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }
}
