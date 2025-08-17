import 'package:egypto/shared/widgets/bottom_sheets/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/di/locator.dart';

class ChangeLanguageAppBarButton extends StatelessWidget {
  const ChangeLanguageAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      // onTap: () => localeNotifier.value.languageCode == 'ar'
      //     ? localeNotifier.value = const Locale('en')
      //     : localeNotifier.value = const Locale('ar'),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => const ChangeLanguageBottomSheet(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/icons/translation.svg",
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            Text(
              localeNotifier.value.languageCode == "ar" ? "عربي" : "EN",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
