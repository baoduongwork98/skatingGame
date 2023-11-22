import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu(
      {super.key,
      this.onResumePressed,
      this.onRestartPressed,
      this.onExitPressed});
  static const id = 'PauseMenu';
  final VoidCallback? onResumePressed;
  final VoidCallback? onRestartPressed;
  final VoidCallback? onExitPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Skating Game', style: TextStyle(fontSize: 30)),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onResumePressed,
                child: const Text('Resume'),
              ),
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onRestartPressed,
                child: const Text('Restart'),
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
