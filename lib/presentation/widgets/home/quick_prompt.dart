import 'package:flutter/material.dart';

class QuickPrompts extends StatelessWidget {
  const QuickPrompts({super.key, required this.title, required this.iconPath});

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF1E1E1E)),
          borderRadius: BorderRadius.circular(200),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Container(
            width: 36,
            height: 36,
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              color: const Color(0xFF191919),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(160),
              ),
            ),
            child: Text(
              '📖',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'SomarSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
