import 'package:flutter/material.dart';
import 'package:interview_helper/src/utils/constants/app_colors.dart';
import 'package:interview_helper/src/utils/view_utils.dart';

class ThemeConfig {
  ThemeConfig._();

  static final ThemeConfig _init = ThemeConfig._();
  static ThemeConfig get init => _init;

  final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      titleTextStyle: ViewUtils.ubuntuStyle(fontSize: 22),
    ),
    drawerTheme: DrawerThemeData(
      surfaceTintColor: Colors.grey.shade100,
      backgroundColor: Colors.grey.shade100,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
  );
}
