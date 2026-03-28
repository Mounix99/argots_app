import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco_rounded,
              size: 80,
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Agrost',
              style: context.textTheme.displayLarge?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 56),
            CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
