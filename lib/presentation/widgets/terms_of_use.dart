
import 'package:flutter/material.dart';

import '../../config/resources/colors.dart';
import '../../l10n/app_localizations.dart';

class TermsOfUseRichText extends StatelessWidget {
  const TermsOfUseRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${AppLocalizations.of(context)!.review} ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.termsOfUse,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: primaryColor,
            ),
          ),
          TextSpan(
            text: ' ${AppLocalizations.of(context)!.and} ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.privacyPolicy,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: primaryColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
