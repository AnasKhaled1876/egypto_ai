import 'package:egypto/features/start/presentation/screens/login.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

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
        context.pushNamed(StartScreen.routeName);
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
