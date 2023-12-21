import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xfffdcc26);
const Color secondaryColor = Color(0xff2658fd);

final TextTheme restaurantTextTheme = TextTheme(
  titleLarge: GoogleFonts.montserrat(
      fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -1.5),
  titleMedium: GoogleFonts.montserrat(
      fontSize: 27, fontWeight: FontWeight.w700, letterSpacing: -0.5),
  titleSmall: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700),
  headlineLarge: GoogleFonts.firaSans(
      fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineMedium:
      GoogleFonts.firaSans(fontSize: 23, fontWeight: FontWeight.w400),
  headlineSmall: GoogleFonts.firaSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  displayLarge: GoogleFonts.palanquin(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  displayMedium: GoogleFonts.palanquin(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  displaySmall: GoogleFonts.palanquin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyLarge: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
);
