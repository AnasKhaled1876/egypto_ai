import 'package:flutter/material.dart';

import '../../locator.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      padding: EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF141414),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      ),
      child: Transform.flip(
        flipX: localeNotifier.value.languageCode == 'ar',
        child: icon,
      ),
    );
  }
}
