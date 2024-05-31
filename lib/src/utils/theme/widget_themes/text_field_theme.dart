import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: greyColor,
    labelStyle: TextStyle(color: greyColor, fontSize: 16.0),
    hintStyle: TextStyle(
      color: black,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: greyColor),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: whiteColor,
          labelStyle: TextStyle(color: whiteColor, fontSize: 16.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: whiteColor),
          ));
}
