import 'package:egypto/l10n/app_localizations.dart';
import 'package:egypto/shared/widgets/icons/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  const ChangeLanguageBottomSheet({super.key});

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
              AppLocalizations.of(context)!.selectLanguage,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 100,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/pyramid.png"),
                    ),
                    Text(
                      "English",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.voteForMore,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
