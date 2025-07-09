import 'package:flutter/material.dart';
import '../resources/colors.dart';

const primaryBackgroundColor = Color(0xFF0F0F0F);
const darkSurfaceColor = Color(0xFF141414);
const neutralColor = Color(0xFF1A1A1A);

final ColorScheme darkColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  tertiary: neutralColor,
  brightness: Brightness.dark,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  error: dangerColor,
  onError: Colors.white,
  surface: neutralColor,
  onSurface: Colors.white,
);
