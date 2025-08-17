import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        ],
      ),
    );
  }
}
