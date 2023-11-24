import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:skating_game/routes/arrow_button.dart';
import 'package:skating_game/routes/gameplay.dart';

class Input extends Component
    with KeyboardHandler, HasGameReference, HasAncestor<GamePlay> {
  Input({Map<LogicalKeyboardKey, VoidCallback>? keyCallbacks})
      : _keyCallbacks = keyCallbacks ?? <LogicalKeyboardKey, VoidCallback>{};

  bool _leftPressed = false;
  bool _rightPressed = false;
  final btnSize = 64;
  final margin = 16.0;
  var _leftInput = 0.0;
  var _rightInput = 0.0;
  static const _sensitivity = 2.0;

  var hAxis = 0.0;
  @override
  FutureOr<void> onLoad() async {
    // TODO: implement onLoad
    return super.onLoad();
  }

  final Map<LogicalKeyboardKey, VoidCallback> _keyCallbacks;

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (game.paused == false) {
      ancestor.leftPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
          keysPressed.contains(LogicalKeyboardKey.arrowLeft);
      ancestor.rightPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
          keysPressed.contains(LogicalKeyboardKey.arrowRight);
      if (event is RawKeyDownEvent && event.repeat == false) {
        for (final entry in _keyCallbacks.entries) {
          if (entry.key == event.logicalKey) {
            entry.value.call();
          }
        }
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
