import 'package:egypto/config/di/locator.dart';
import 'package:egypto/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/resources/app_assets.dart';

class WordLogo extends StatelessWidget {
  const WordLogo({super.key, this.fontSize});

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: 'logo',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(AppAssets.logo, height: 32),
          ),
        ),
        const SizedBox(width: 12),
        Hero(
          tag: 'word-logo',
          child: localeNotifier.value.languageCode == 'ar'
              ? Text(
                  AppLocalizations.of(context)!.egypto,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontFamily: localeNotifier.value.languageCode == 'ar'
                        ? 'Outfit'
                        : 'Syne',
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                )
              : SvgPicture.asset("assets/icons/word-logo.svg", height: 35),
        ),
      ],
    );
  }
}
