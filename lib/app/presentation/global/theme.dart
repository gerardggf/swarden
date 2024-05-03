import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';

class SWardenTheme {
  static final ThemeData lightTeme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.light),
      backgroundColor: AppColors.bg,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.light,
        fontSize: 26,
      ),
    ),
  );
}
