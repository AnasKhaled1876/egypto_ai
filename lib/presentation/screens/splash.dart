import 'package:egypto/locator.dart';
import 'package:egypto/presentation/cubits/profile/profile_cubit.dart';
import 'package:egypto/presentation/screens/home.dart';
import 'package:egypto/presentation/screens/start/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _isInitialized = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = locator<SharedPreferences>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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

    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) async {
    if (status == AnimationStatus.completed && !_isInitialized) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkFirstLaunch();
      });
    }
  }

  Future<void> _checkFirstLaunch() async {
    final isFirstLaunch = _prefs.getBool('is_first_launch') ?? true;

    if (isFirstLaunch) {
      // First launch, navigate to welcome screen
      await _prefs.setBool('is_first_launch', false);
      if (mounted) {
        context.pushNamed(WelcomeScreen.routeName);
      }
    } else {
      // Not first launch, check auth state
      await _checkAuthState();
    }
  }

  Future<void> _checkAuthState() async {
    final token = await locator<FlutterSecureStorage>().read(key: 'token');

    if (token == null) {
      // No token, navigate to home (or login if you prefer)
      if (mounted) {
        context.pushNamed(HomeScreen.routeName);
      }
    } else {
      // Token exists, get profile
      if (mounted) {
        await _getProfile();
      }
    }
  }

  Future<void> _getProfile() async {
    final profileCubit = context.read<ProfileCubit>();
    try {
      await profileCubit.getProfile();
      // If we get here, profile was fetched successfully
      if (mounted) {
        context.pushNamed(HomeScreen.routeName);
      }
    } catch (e) {
      // Handle error - navigate to home or show error
      if (mounted) {
        context.pushNamed(HomeScreen.routeName);
      }
    }
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
        builder: (BuildContext context, Widget? child) => Container(
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
            child: Hero(
              tag: 'logo',
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
          ),
          // child: ,
        ),
      ),
    );
  }
}
