import 'package:flutter/material.dart';

class LoadingAnimationWidget extends StatelessWidget {
  const LoadingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 5,
        ),
      ),
    );
  }
}
