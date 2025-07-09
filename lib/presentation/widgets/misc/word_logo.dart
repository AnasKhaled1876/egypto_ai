import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../locator.dart';

class WordLogo extends StatelessWidget {
  const WordLogo({super.key, this.fontSize});

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.egypto,
      style: TextStyle(
        fontFamily: localeNotifier.value.languageCode == 'ar'
            ? 'SomarSans'
            : 'Syne',
        fontSize: localeNotifier.value.languageCode == 'ar'
            ? fontSize ?? 50
            : fontSize ?? 57,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
