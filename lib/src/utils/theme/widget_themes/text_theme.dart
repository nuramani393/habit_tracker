import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HTextTheme {
  HTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    //splashScreen
    displayLarge: GoogleFonts.poppins(
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    //onboard screen
    displayMedium: GoogleFonts.poppins(
      fontSize: 26,
      fontWeight: FontWeight.w500, //semibold
      color: Colors.black,
    ),

    displaySmall: GoogleFonts.poppins(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    //onboard screen
    headlineLarge: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w600, //semibold
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18,
      // fontWeight: FontWeight.w300, //light
      color: Colors.black,
      height: 1.5,
    ),

    //button login //bold
    headlineSmall: GoogleFonts.poppins(
      fontSize: 16,
      // fontWeight: FontWeight.w400,
      color: Colors.black,
    ),

//date on appbar
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.black,
    ),

    titleMedium: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
// khas untuk forget pass
    labelMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 13,
      // fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    bodyLarge: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
    ),

    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),

//i use this in setings page
    bodySmall: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    //splashScreen
    displayLarge: GoogleFonts.poppins(
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    //onboard screen
    displayMedium: GoogleFonts.poppins(
      fontSize: 26,
      fontWeight: FontWeight.w500, //semibold
      color: Colors.white,
    ),

    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    //onboard screen
    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600, //semibold
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w300, //light
      color: Colors.white,
      height: 1.5,
    ),

    //button login //bold
    headlineSmall: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    //text

    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    labelMedium: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

    labelSmall: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),

    bodySmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}
