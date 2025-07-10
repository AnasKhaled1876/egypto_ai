import 'package:flutter/material.dart';
import '../../../config/di/locator.dart';

class LinearProgressBar extends StatelessWidget {
  final double progress;
  final double borderRadius;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color progressColor;

  const LinearProgressBar({
    super.key,
    this.progress = 0.0,
    this.borderRadius = 0.0,
    this.height = 3.0,
    this.backgroundColor = Colors.transparent,
    this.progressColor = Colors.blue,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: languageCode == "en"
            ? Alignment.centerLeft
            : Alignment.centerRight,
        widthFactor: progress,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          duration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
