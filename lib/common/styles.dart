import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xfffdcc26);
const Color secondaryColor = Color(0xff2658fd);

final TextTheme restaurantTextTheme = TextTheme(
  titleLarge: GoogleFonts.merriweather(
      fontSize: 32, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  titleMedium: GoogleFonts.merriweather(
      fontSize: 27, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  titleSmall:
      GoogleFonts.merriweather(fontSize: 24, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.merriweather(
      fontSize: 27, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineMedium:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  headlineSmall: GoogleFonts.merriweather(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  displayLarge: GoogleFonts.merriweather(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  displayMedium: GoogleFonts.merriweather(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  displaySmall: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyLarge: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
);
