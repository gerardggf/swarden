import 'package:flutter/material.dart';
import 'package:swarden/app/core/const/colors.dart';
import 'package:swarden/app/core/const/fonts.dart';

class SWardenTheme {
  static final ThemeData lightTeme = ThemeData(
    fontFamily: Fonts.barlow,
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
    dialogBackgroundColor: AppColors.bg,
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.light;
          }
          return AppColors.bg;
        },
      ),
      trackOutlineColor: const WidgetStatePropertyAll(AppColors.light),
      thumbColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.bg;
          }
          return AppColors.light;
        },
      ),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: AppColors.light,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.light,
      selectionColor: AppColors.light.withOpacity(0.3),
      selectionHandleColor: AppColors.light,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.light),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.light),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.light),
      ),
    ),
  );
}
