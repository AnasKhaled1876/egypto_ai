import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF0A0A0A),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    
    backgroundColor: const Color(0xFF0F0F0F),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: const Color(0xFF666666),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF618B4A),
    secondary: Color(0xFF1A1A1A),
    surface: Color(0xFF1A1A1A),
    error: Colors.red,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF618B4A),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w600,
    ),
  ),
);
