import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skating_game/routes/gameplay.dart';

class RetryMenu extends StatelessWidget {
  RetryMenu({
    super.key,
    this.onRetryPressed,
    this.onExitPressed,
    required this.gameScore,
  });
  static const id = 'RetryMenu';
  final VoidCallback? onRetryPressed;
  final VoidCallback? onExitPressed;
  final int gameScore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Game Over', style: TextStyle(fontSize: 30)),
            Text('Score: ${gameScore}', style: const TextStyle(fontSize: 30)),
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
