import 'package:flutter/material.dart';

class BubbleButton extends StatelessWidget {
  const BubbleButton({super.key, required this.title, required this.onTap});

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
                    Color(0xFF4E7F62),
                    Color(0xFF20639B),
                    Color(0xFF1C2895),
                  ],
                  stops: [0.0, 0.4, 0.85, 1.0],
                  begin: AlignmentDirectional(-1.0, 1.0),
                  end: AlignmentDirectional(1.0, -1.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2000),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
