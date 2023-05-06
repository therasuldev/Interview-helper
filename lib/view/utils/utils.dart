import 'package:flutter/material.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCard() => BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 10),
            spreadRadius: .5,
            blurRadius: 10,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.blueGrey[200]!,
          ],
          stops: const [0.5, 1],
        ),
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
}
