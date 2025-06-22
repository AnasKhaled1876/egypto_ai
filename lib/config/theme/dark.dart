import 'package:flutter/material.dart';
import '../resources/colors.dart';

const primaryBackgroundColor = Color(0xFF0F0F0F);
const secondaryBackgroundColor = Color(0xFF141414);
const neutralColor = Color(0xFF1A1A1A);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF0A0A0A),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: primaryBackgroundColor,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: const Color(0xFF666666),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: primaryColor,
    accentColor: secondaryColor,
    cardColor: neutralColor,
    backgroundColor: primaryBackgroundColor,
    errorColor: dangerColor,
    brightness: Brightness.dark,
  ),
  primaryColor: primaryColor,
  useMaterial3: true,
  iconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF141414),
    hintStyle: const TextStyle(
      color: Color(0xFF666666),
      fontSize: 16,
      fontFamily: 'SomarSans',
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'SomarSans',
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  fontFamily: 'SomarSans',
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 41,
      fontWeight: FontWeight.w700,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H1

    displayMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H2

    displaySmall: TextStyle(
      fontSize: 29,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H3

    headlineLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H4

    headlineMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w500,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H5

    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 1.3,
      letterSpacing: 0.5,
    ), // H6
    // PARAGRAPHS
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.2,
    ), // XL / Large Paragraph

    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.2,
    ), // Medium Paragraph

    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.2,
    ), // Small Paragraph
    // LABELS / CAPTIONS
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
      letterSpacing: 0.2,
    ), // Large Label or XL Caption

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4,
      letterSpacing: 0.2,
    ), // Medium Label or L Caption

    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 0.2,
    ), // XS Label or M Caption
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'SomarSans',
      fontWeight: FontWeight.w600,
    ),
  ),
);
