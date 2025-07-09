import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.or,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF555555),
            fontSize: 14.22,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
