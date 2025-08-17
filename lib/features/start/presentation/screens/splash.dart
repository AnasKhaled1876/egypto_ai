import 'package:egypto/config/resources/app_assets.dart';
import 'package:egypto/features/start/presentation/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/locator.dart';
import '../../../../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> width;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    width = Tween<double>(
      begin: 0,
      end: 120,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward().then(
      (value) => context.pushNamed(WelcomeScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(AppAssets.logo, height: 36),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => SizedBox(
                width: width.value,
                height: 36,
                child: Text(
                  AppLocalizations.of(context)!.egypto,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontFamily: localeNotifier.value.languageCode == 'ar'
                        ? 'Outfit'
                        : 'Syne',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
