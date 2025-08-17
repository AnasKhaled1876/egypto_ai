import 'package:flutter/material.dart';
import '../../../config/di/locator.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({required this.icon, super.key, this.onTap});

  final Widget icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(200),
      child: Container(
        padding: const EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
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
