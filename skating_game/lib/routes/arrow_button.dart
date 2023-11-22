// import 'dart:async';
// import 'dart:ui';

// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:skating_game/routes/gameplay.dart';

// class ArrowButton extends SpriteComponent
//     with HasGameReference, TapCallbacks, HasAncestor<GamePlay> {
//   final btnSize = 64;
//   final margin = 16.0;
//   ArrowButton({this.isLeftBnt = true});
//   late final bool isLeftBnt;
//   var hAxis = 0.0;
//   var _leftInput = 0.0;
//   var _rightInput = 0.0;
//   static const _sensitivity = 2.0;
//   bool leftPressed = false;
//   bool rightPressed = false;
//   @override
//   FutureOr<void> onLoad() {
//     if (isLeftBnt) {
//       sprite = Sprite(game.images.fromCache('HUD/ButtonLeft.png'));
//       position = Vector2(margin, game.size.y - btnSize - margin);
//     } else {
//       sprite = Sprite(game.images.fromCache('HUD/ButtonRight.png'));
//       position = Vector2(
//           game.size.x - btnSize - margin, game.size.y - btnSize - margin);
//     }
//     return super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     _leftInput =
//         lerpDouble(_leftInput, leftPressed ? 1.5 : 0, _sensitivity * dt)!;
//     _rightInput =
//         lerpDouble(_rightInput, rightPressed ? 1.5 : 0, _sensitivity * dt)!;
//     hAxis = _rightInput - _leftInput;
//     super.update(dt);
//   }

//   @override
//   void onTapDown(TapDownEvent event) {
//     if (game.paused == false) {
//       if (isLeftBnt) {
//         ancestor.input.leftPressed = true;
//       } else {
//         ancestor.input.rightPressed = true;
//       }
//     }
//     super.onTapDown(event);
//   }
// }
