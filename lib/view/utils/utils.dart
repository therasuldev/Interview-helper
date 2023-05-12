import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCard() => BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!,
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
  static questionCard() => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            offset: const Offset(0, 5),
            spreadRadius: .5,
            blurRadius: 2,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.blue.shade50,
          ],
          stops: const [0.3, 1],
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      );

  // Ubuntu Google fonts
  static ubuntuStyle({FontWeight? fontWeight, double? fontSize}) {
    return GoogleFonts.ubuntu(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize,
    );
  }
}
