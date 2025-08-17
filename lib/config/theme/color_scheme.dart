import 'package:flutter/material.dart';
import 'colors.dart';

final ColorScheme darkColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  tertiary: neutralColor,
  brightness: Brightness.dark,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  error: dangerColor,
  onError: Colors.white,
  surfaceBright: darkSurfaceLowColor,
  surface: darkSurfaceMediumColor,
  surfaceDim: darkSurfaceHighColor,
  onSurface: Colors.white,
  outline: darkHighLineColor,
  // onSurfaceVariant: neutralColor,
);

final ColorScheme lightColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  tertiary: neutralColor,
  brightness: Brightness.light,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  error: dangerColor,
  onError: Colors.white,
  surface: darkSurfaceLowColor,
  onSurface: Colors.white,
);
