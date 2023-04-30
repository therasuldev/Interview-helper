import 'package:flutter/material.dart';

class ViewUtils {
  static categoryBox({required List<Color> colors, required Color boxColor}) =>
      BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: boxColor,
            offset: const Offset(0, 10),
            spreadRadius: .5,
            blurRadius: 10,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: const [0.5, 1],
        ),
        borderRadius: BorderRadius.circular(15),
      );
}
