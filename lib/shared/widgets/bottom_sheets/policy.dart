import 'package:egypto/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../../enums/policy.dart';
import '../icons/icon_container.dart';

class PolicyBottomSheet extends StatelessWidget {
  const PolicyBottomSheet({super.key, required this.policy});
  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 30,
        children: [
          AppBar(
            leading: IconContainer(
              icon: const Icon(Icons.close),
              onTap: () => context.pop(),
            ),
            title: Text(
              AppLocalizations.of(context)!.termsOfUse,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF191919),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
              ),
            ),
            child: Text(
              'Last Updated: ${DateFormat("MMMM d, yyyy").format(DateTime.now())}',
              style: const TextStyle(
                color: captionColor,
                fontSize: 12.80,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: 353,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Introduction about ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'egypto.ai ',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..shader = RadialGradient(
                          center: Alignment.center,
                          radius: 13,
                          colors: [
                            primaryColor.shade900,
                            primaryColor.shade500,
                            Colors.white,
                            secondaryColor.shade300,
                          ],

                          stops: const [0.0, 0.22, 0.60, 0.86],
                        ).createShader(const Rect.fromLTWH(0, 0, 180, 120)),
                    ),
                  ),
                  const TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
