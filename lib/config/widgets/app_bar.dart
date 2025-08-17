import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransparentAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TransparentAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
