import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class ActionButton extends SpriteComponent with HasGameRef, TapCallbacks {
  final VoidCallback? actionButton;
  final String imgButton;
  ActionButton({
    required this.imgButton,
    required this.actionButton,
    super.position,
    super.size,
  });
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/$imgButton.png'));
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    actionButton?.call();
    super.onTapUp(event);
  }
}
