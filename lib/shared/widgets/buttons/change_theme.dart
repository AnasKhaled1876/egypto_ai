import 'package:egypto/config/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => themeNotifier.value = themeNotifier.value == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset( "assets/icons/sun.svg", height: 24, width: 24),
      ),
    );
  }
}
