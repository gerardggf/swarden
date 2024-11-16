import 'package:flutter/material.dart';

extension TextStylesExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get bodyThemeL => textTheme.bodyLarge;
  TextStyle? get bodyThemeM => textTheme.bodyMedium;
  TextStyle? get bodyThemeS => textTheme.bodySmall;

  TextStyle? get titleThemeL => textTheme.titleLarge;
  TextStyle? get titleThemeM => textTheme.titleMedium;
  TextStyle? get titleThemeS => textTheme.titleSmall;

  TextStyle? get labelThemeL => textTheme.labelLarge;
  TextStyle? get labelThemeM => textTheme.labelMedium;
  TextStyle? get labelThemeS => textTheme.labelSmall;

  TextStyle? get displayThemeL => textTheme.displayLarge;
  TextStyle? get displayThemeM => textTheme.displayMedium;
  TextStyle? get displayThemeS => textTheme.displaySmall;
}
