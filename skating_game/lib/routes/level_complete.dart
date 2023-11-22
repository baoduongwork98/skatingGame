import 'package:flutter/material.dart';

class LevelComplete extends StatelessWidget {
  const LevelComplete(
      {super.key,
      this.onNextLevelPressed,
      this.onRestartPressed,
      this.onExitPressed});
  static const id = 'LevelComplete';
  final VoidCallback? onNextLevelPressed;
  final VoidCallback? onRestartPressed;
  final VoidCallback? onExitPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LevelComplete', style: TextStyle(fontSize: 30)),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onNextLevelPressed,
                child: const Text('Next Level'),
              ),
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onRestartPressed,
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
