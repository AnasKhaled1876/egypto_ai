
import '../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.termsOfUse,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(
            text: ' ${AppLocalizations.of(context)!.and} ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.privacyPolicy,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14.22,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
