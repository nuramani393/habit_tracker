import 'package:flutter/material.dart';
import 'package:habit_tracker/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:habit_tracker/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:habit_tracker/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:habit_tracker/src/utils/theme/widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: HTextTheme.lightTextTheme,
      outlinedButtonTheme: HOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: HElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: HTextTheme.darkTextTheme,
      outlinedButtonTheme: HOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: HElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme);
}
