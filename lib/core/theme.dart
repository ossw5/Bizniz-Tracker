import 'package:flutter/material.dart';

// Minimalist color palette
const Color kTealDark = Color(0xFF005057); // primary
const Color kTeal = Color(0xFF00777E); // secondary
const Color kBrownDark = Color(0xFF4B3217);
const Color kBrown = Color(0xFF785230);
const Color kBeige = Color(0xFFAE9276);

final ThemeData appTheme = ThemeData(
  useMaterial3: false,
  primaryColor: kTealDark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kTealDark,
    primary: kTealDark,
    secondary: kTeal,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: kBrownDark,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kTealDark,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kTealDark,
      side: BorderSide(color: Color.fromRGBO(174, 146, 118, 0.6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: kTealDark),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kTeal,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: kTealDark,
    unselectedItemColor: Colors.grey.shade600,
    showUnselectedLabels: true,
  ),
  // Cards: use subtle beige surface for lifted elements via surfaceColor
  cardColor: Color.fromRGBO(174, 146, 118, 0.14),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: kBrownDark, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(color: kBrownDark),
  ),
);
