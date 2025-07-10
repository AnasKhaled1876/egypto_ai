import 'package:egypto/features/chat/presentation/widgets/live_amplitude_bar.dart';
import 'package:egypto/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/di/locator.dart';
import '../../../../config/resources/app_assets.dart';
import '../../../home/presentation/screens/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(color: Color(0xFF0A0A0A)),
        child: Center(
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
              const LiveAmplitudeBar(),
              // const SizedBox(width: 70, child: SplashLoadingIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashLoadingIndicator extends StatefulWidget {
  const SplashLoadingIndicator({super.key});

  @override
  State<SplashLoadingIndicator> createState() => _SplashLoadingIndicatorState();
}

class _SplashLoadingIndicatorState extends State<SplashLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    _controller.addListener(() {
      if (_controller.isCompleted) {
        context.pushNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _controller.value,
        borderRadius: BorderRadius.circular(200),
        color: Colors.white,
        backgroundColor: const Color(0xFF1F1E1E),
      ),
    );
  }
}
