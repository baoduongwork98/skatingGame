import 'dart:async';
import 'dart:ffi';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:skating_game/routes/gameplay.dart';

class SnowMan extends PositionComponent
    with HasGameReference, HasAncestor<GamePlay> {
  SnowMan({super.position, required Sprite sprite})
      : _body = SpriteComponent(
          sprite: sprite,
          anchor: Anchor.center,
        ) {
    size = Vector2.all(16);
  }

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

  void collect() {
    if (ancestor.musicValueNotifier.value)
      FlameAudio.play('collect_snowman.wav', volume: ancestor.soundVolume);
    addAll([
      OpacityEffect.fadeOut(LinearEffectController(0.4),
          target: _body, onComplete: removeFromParent),
      ScaleEffect.by(
        Vector2.all(1.2),
        LinearEffectController(0.4),
      )
    ]);
  }
}
