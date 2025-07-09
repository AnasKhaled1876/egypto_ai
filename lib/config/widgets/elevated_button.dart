import 'package:flutter/material.dart';

ButtonStyle defaultElevatedButtonStyle({
  required BuildContext context,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(MediaQuery.sizeOf(context).width, 48),
    backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
    foregroundColor: foregroundColor ?? Theme.of(context).cardColor,
    padding:
        padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    textStyle:
        textStyle ??
        const TextStyle(
          fontSize: 16,
          fontFamily: 'SomarSans',
          fontWeight: FontWeight.w600,
        ),
  );
}

ButtonStyle gradientElevatedButtonStyle({
  required BuildContext context,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(MediaQuery.sizeOf(context).width, 48),
    padding:
        padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    backgroundBuilder: (context, states, child) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
          colors: [
            Color(0xFF00A3A4),
            Color(0xFF00BCA1),
            Color(0xFF20639B),
            Color(0xFF1C2895),
          ],
          stops: [0, 0.32, 0.74, 1],
        ),
      ),
      child: child,
    ),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 48),
    ),
    elevation: 0,
  );
}
