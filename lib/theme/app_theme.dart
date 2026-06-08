import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.navy,
  scaffoldBackgroundColor: AppColors.cream,
  fontFamily: GoogleFonts.sourceSerif4().fontFamily,
  colorScheme: ColorScheme.light(
    primary: AppColors.navy,
    secondary: AppColors.gold,
    surface: AppColors.white,
    background: AppColors.cream,
    error: AppColors.red,
    onPrimary: AppColors.white,
    onSecondary: AppColors.navy,
    onSurface: AppColors.text,
    onBackground: AppColors.text,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.navy,
    elevation: 0,
    titleTextStyle: GoogleFonts.sourceSerif4(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.navy,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.sourceSerif4(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.gold, width: 2),
    ),
    labelStyle: const TextStyle(color: AppColors.navy),
    hintStyle: const TextStyle(color: AppColors.muted),
  ),
  cardTheme: CardThemeData(
    color: AppColors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.border, width: 0.5),
    ),
  ),
);
