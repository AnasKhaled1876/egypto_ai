import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  const BubbleButton({required this.title, required this.onTap, super.key});

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(2000),
            onTap: onTap,
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    const Color(0xFF4E7F62),
                    const Color(0xFF20639B),
                    const Color(0xFF1C2895),
                  ],
                  stops: const [0.0, 0.4, 0.85, 1.0],
                  begin: const AlignmentDirectional(-1.0, 1.0),
                  end: const AlignmentDirectional(1.0, -1.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2000),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
