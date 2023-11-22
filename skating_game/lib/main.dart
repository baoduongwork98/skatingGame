import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skating_game/skating_game.dart';

void main() {
  runApp(const SkatingGameApp());
}

class SkatingGameApp extends StatelessWidget {
  const SkatingGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget.controlled(gameFactory: SkatingGame.new),
    );
  }
}
