import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:skating_game/routes/gameplay.dart';

class RockComponent extends PositionComponent
    with HasGameReference, HasAncestor<GamePlay> {
  RockComponent(
      {super.position, required Sprite sprite, required this.onRetryPressed})
      : _body = SpriteComponent(
          sprite: sprite,
          anchor: Anchor.center,
        ) {
    size = Vector2.all(16);
  }
  final VoidCallback onRetryPressed;
  final SpriteComponent _body;
  @override
  FutureOr<void> onLoad() async {
    await add(_body);
    await add(CircleHitbox.relative(1,
        parentSize: _body.size,
        anchor: Anchor.center,
        collisionType: CollisionType.passive));
    return super.onLoad();
  }

  void collisionPlayer() {
    onRetryPressed.call();
  }
}
