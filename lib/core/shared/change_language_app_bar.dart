import 'package:egypto/utils/helpers/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../locator.dart';

class ChangeLanguageAppBarButton extends StatelessWidget {
  const ChangeLanguageAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => localeNotifier.value.languageCode == 'ar'
          ? localeNotifier.value = const Locale('en')
          : localeNotifier.value = const Locale('ar'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1E26),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/icons/globe.svg", height: 24, width: 24),
            const SizedBox(width: 12),
            Text(
              localeNotifier.value.languageCode.toTitleCase(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
