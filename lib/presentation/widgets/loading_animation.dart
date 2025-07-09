import 'dart:math';

import 'package:flutter/material.dart';

class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({super.key, this.size = 30.0});

  final double size;

  @override
  State<LoadingAnimationWidget> createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(); // Infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: CustomPaint(painter: _GradientArcPainter()),
          );
        },
      ),
    );
  }
}

class _GradientArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 3.5;
    final radius = (size.width - strokeWidth) / 4;

    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: radius,
    );

    final gradient = const SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: [
        Color(0xFF618B4A),
        Color(0xFF4E7F62),
        Color(0xFF20639B),
        Color(0xFF1C2895),
      ],
      stops: [0.0, 0.32, 0.74, 1],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw only a partial arc like a loader
    final startAngle = 0.0;
    final sweepAngle = pi * 1.5; // 270 degrees
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
