import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolistapp/common/commoncolor.dart';

class CommonTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Commoncolor.white,
      secondary: Commoncolor.black,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Commoncolor.black,
      secondary: Commoncolor.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true
  );
}