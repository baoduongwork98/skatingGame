import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:skating_game/skating_game.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({
    super.key,
    this.currentLevel,
    this.onLevelSelected,
    this.goBackPressed,
  });
  final currentLevel;
  static const id = 'LevelSelection';
  final ValueChanged<int>? onLevelSelected;
  final VoidCallback? goBackPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose Level', style: TextStyle(fontSize: 30)),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: GridView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 50,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                        onPressed: index <= currentLevel
                            ? () => onLevelSelected?.call(index)
                            : null,
                        child: Text('Level ${index + 1}'));
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: goBackPressed,
                child: const Text('Goback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
