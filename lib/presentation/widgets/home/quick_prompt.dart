import 'package:egypto_ai/presentation/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickPrompts extends StatelessWidget {
  const QuickPrompts({super.key, required this.title, required this.emoji});

  final String title;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(200),
      onTap: () {
        context.pushNamed(ChatScreen.routeName, extra: title);
      },
      child: Container(
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
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFF191919),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(160),
                ),
              ),
              child: Text(
                emoji,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
