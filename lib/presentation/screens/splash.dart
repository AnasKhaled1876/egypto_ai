import 'package:egypto_ai/presentation/screens/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _logoSizeAnimation;
  late Animation<double> _wordLogoSizeAnimation;

  // Define your image sizes
  final double minLogoSize = 50.0;
  final double maxLogoSize = 200.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..forward();

    // Size animation for logo
    _logoSizeAnimation = Tween<double>(
      begin: maxLogoSize,
      end: minLogoSize,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _wordLogoSizeAnimation = Tween<double>(
      begin: 0,
      end: 180,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Opacity animation for additional widget
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Optional: Add navigation after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            context.pushNamed(GetStartedScreen.routeName);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnimatedBuilder(
        animation: _controller,
        builder:
            (BuildContext context, Widget? child) => Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/splash_background.png"),
                  fit: BoxFit.cover,
                  opacity: _opacityAnimation.value,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: _logoSizeAnimation.value,
                      height: _logoSizeAnimation.value,
                    ),
                    SizedBox(width: 12),
                    SvgPicture.asset(
                      "assets/icons/word-logo.svg",
                      width: _wordLogoSizeAnimation.value,
                    ),
                  ],
                ),
              ),
              // child: ,
            ),
      ),
    );
  }
}
