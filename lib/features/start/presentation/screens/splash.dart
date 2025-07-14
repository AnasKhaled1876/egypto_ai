import 'package:egypto/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../config/di/locator.dart';
import '../../../../config/resources/app_assets.dart';
import '../widgets/splash_loading_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(AppAssets.logo, height: 60),
              ),
            ),
            const SizedBox(height: 12),
            Hero(
              tag: 'word-logo',
              child: Text(
                AppLocalizations.of(context)!.egypto,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontFamily: localeNotifier.value.languageCode == 'ar'
                      ? 'SomarSans'
                      : 'Syne',
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 36),
            // const LiveAmplitudeBar(),
            const SizedBox(width: 70, child: SplashLoadingIndicator()),
          ],
        ),
      ),
    );
  }
}
