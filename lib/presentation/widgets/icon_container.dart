import 'package:egypto_ai/config/resources/colors.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon, this.onTap});

  final Widget icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(200),
      child: Container(
        padding: EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: secondaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        child: Transform.flip(
          flipX: localeNotifier.value.languageCode == 'ar',
          child: icon,
        ),
      ),
    );
  }
}
