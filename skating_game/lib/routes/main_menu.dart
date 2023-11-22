import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
    this.onPlayPressed,
    this.onSettingsPressed,
  });
  static const id = 'MainMenu';
  final VoidCallback? onPlayPressed;
  final VoidCallback? onSettingsPressed;
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
                onPressed: onPlayPressed,
                child: const Text('Start Game'),
              ),
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onSettingsPressed,
                child: const Text('Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
