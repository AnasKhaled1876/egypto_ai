import 'package:egypto/config/theme/color_scheme.dart';
import 'package:egypto/config/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

ThemeData buildDarkTheme({required String fontFamily}) {
  return ThemeData(
    scaffoldBackgroundColor: darkColorScheme.surface,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: darkColorScheme,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(200)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    fontFamily: fontFamily,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 0),
  );
}

ThemeData buildLightTheme({required String fontFamily}) {
  return ThemeData(
    scaffoldBackgroundColor: darkColorScheme.surface,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: darkColorScheme,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(200)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    fontFamily: fontFamily,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 0),
  );
}

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30, 60, 87, 1),
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: const Color(0xFF292929)),
    borderRadius: BorderRadius.circular(20),
  ),
);
