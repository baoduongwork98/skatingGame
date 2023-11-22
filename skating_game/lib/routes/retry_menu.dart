import 'package:flutter/material.dart';

class RetryMenu extends StatelessWidget {
  const RetryMenu({super.key, this.onRetryPressed, this.onExitPressed});
  static const id = 'RetryMenu';
  final VoidCallback? onRetryPressed;
  final VoidCallback? onExitPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Game Over', style: TextStyle(fontSize: 30)),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onRetryPressed,
                child: const Text('Retry'),
              ),
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onExitPressed,
                child: const Text('Exit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
