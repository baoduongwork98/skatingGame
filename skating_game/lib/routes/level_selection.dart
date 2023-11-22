import 'package:flutter/material.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({
    super.key,
    this.onLevelSelected,
    this.goBackPressed,
  });
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
                        onPressed: () => onLevelSelected?.call(index + 1),
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
