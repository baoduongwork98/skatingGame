import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:skating_game/routes/gameplay.dart';
import 'package:skating_game/skating_game.dart';

class ArrowButton extends SpriteComponent
    with HasGameRef<SkatingGame>, TapCallbacks, HasAncestor<GamePlay> {
  final btnSize = 64;
  final margin = 16.0;
  ArrowButton({this.isLeftBnt = true});
  late final bool isLeftBnt;
  var hAxis = 0.0;
  var _leftInput = 0.0;
  var _rightInput = 0.0;
  static const _sensitivity = 2.0;
  bool leftPressed = false;
  bool rightPressed = false;
  @override
  FutureOr<void> onLoad() {
    if (isLeftBnt) {
      priority = 1;
      sprite = Sprite(game.images.fromCache('HUD/ButtonLeft.png'));
      position = Vector2(
        margin,
        game.size.y - btnSize - margin,
      );
    } else {
      priority = 1;
      sprite = Sprite(game.images.fromCache('HUD/ButtonRight.png'));
      position = Vector2(
        game.size.x - btnSize - margin,
        game.size.y - btnSize - margin,
      );
    }
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isLeftBnt) {
      ancestor.leftPressed = true;
    } else {
      ancestor.rightPressed = true;
    }
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (isLeftBnt) {
      ancestor.leftPressed = false;
    } else {
      ancestor.rightPressed = false;
    }
    super.onTapUp(event);
  }
}
