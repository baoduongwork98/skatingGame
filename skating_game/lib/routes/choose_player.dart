import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChoosePlayer extends StatelessWidget {
  const ChoosePlayer({super.key, this.onBackPressed});

  static const id = 'ChoosePlayer';

  // final ValueListenable<bool> musicValueListenable;
  // final ValueListenable<bool> sfxValueListenable;

  // final ValueChanged<bool>? onMusicValueChanged;
  // final ValueChanged<bool>? onSfxValueChanged;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ChoosePlayer',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onBackPressed,
                child: const Text('Goback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
