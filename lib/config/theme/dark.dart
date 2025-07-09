import 'package:egypto/config/theme/color_scheme.dart';
import 'package:egypto/config/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../resources/colors.dart';

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
      hintStyle: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(200)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(200)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    fontFamily: fontFamily,
    textTheme: darkTextTheme.apply(fontFamily: fontFamily),
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
