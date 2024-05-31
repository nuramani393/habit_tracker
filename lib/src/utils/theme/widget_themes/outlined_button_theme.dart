import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';

class HOutlinedButtonTheme {
  HOutlinedButtonTheme._();

//Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: black,
        side: const BorderSide(color: black),
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle:
            const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
  );

//Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: whiteColor,
        side: const BorderSide(color: whiteColor),
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle:
            const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
  );
}
