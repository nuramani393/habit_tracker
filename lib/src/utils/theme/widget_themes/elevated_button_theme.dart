import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';

class HElevatedButtonTheme {
  HElevatedButtonTheme._();

//Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: whiteColor,
        backgroundColor: black,
        side: const BorderSide(color: black),
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        )),
  );

//Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: black,
        backgroundColor: whiteColor,
        side: const BorderSide(color: whiteColor),
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        )),
  );
}
