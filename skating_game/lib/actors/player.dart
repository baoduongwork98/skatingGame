import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:skating_game/actors/rock_component.dart';
import 'package:skating_game/actors/snowman.dart';
import 'package:skating_game/routes/gameplay.dart';

class Player extends PositionComponent
    with HasGameReference, HasAncestor<GamePlay>, CollisionCallbacks {
  Player({super.position, required Sprite sprite})
      : _body = SpriteComponent(
          sprite: sprite,
          anchor: Anchor.center,
        ) {
    size = Vector2.all(16);
  }
  late double hAxis;
  final SpriteComponent _body;
  final _moveDirection = Vector2(1, 1);
  static const _maxSpeed = 80;
  late double speed = 0;

  @override
  FutureOr<void> onLoad() async {
    await add(_body);
    await add(CircleHitbox.relative(1,
        parentSize: _body.size, anchor: Anchor.center));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _moveDirection.x = ancestor.hAxis; //ancestor.input.hAxis;
    _moveDirection.y = 1;

    _moveDirection.normalize();
    speed = lerpDouble(speed, _maxSpeed, 0.5 * dt)!;

    angle = _moveDirection.screenAngle() + pi;
    position.addScaled(_moveDirection, speed * dt);
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SnowMan) {
      other.collect();
    } else if (other is RockComponent) {
      other.collisionPlayer();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
