import 'package:flutter/material.dart';

import '../resources/colors.dart';

ButtonStyle defaultElevatedButtonStyle({
  required BuildContext context,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(MediaQuery.sizeOf(context).width, 48),
    backgroundColor: backgroundColor ?? primaryColor,
    foregroundColor: foregroundColor ?? Colors.white,
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
