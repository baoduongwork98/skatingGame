import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:skating_game/actors/rock_component.dart';
import 'package:skating_game/actors/snowman.dart';
import 'package:skating_game/routes/arrow_button.dart';
import 'package:skating_game/input.dart';
import 'package:skating_game/actors/player.dart';
import 'package:skating_game/routes/pause_button.dart';

class GamePlay extends Component with HasGameReference {
  late double hAxis = 0.0;
  late bool leftPressed = false;
  late bool rightPressed = false;
  GamePlay(
    this.currentLevel, {
    super.key,
    required this.onPausePressed,
    required this.onLevelComplete,
    required this.onRetryPressed,
  });
  static const id = 'GamePlay';

  final int currentLevel;
  final VoidCallback onPausePressed;
  final VoidCallback onLevelComplete;
  final VoidCallback onRetryPressed;
  late final input = Input(
    keyCallbacks: {
      LogicalKeyboardKey.keyP: onPausePressed,
      LogicalKeyboardKey.enter: onLevelComplete,
      LogicalKeyboardKey.keyR: onRetryPressed,
    },
  );
  late final World world;
  late final CameraComponent camera;
  late final Player player;

  var _leftInput = 0.0;
  var _rightInput = 0.0;
  static const _sensitivity = 2.0;
  @override
  void update(double dt) {
    handleMoving(dt);
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    final map =
        // await TiledComponent.load('Level-0$currentLevel.tmx', Vector2.all(16));
        await TiledComponent.load('Level-00.tmx', Vector2.all(16));

    await setupWorldAndCamera(map);
    await setupCompoment(map);
    await setupTrigger(map);
    return super.onLoad();
  }

  Future<void> setupCompoment(TiledComponent<FlameGame<World>> map) async {
    final tiles = game.images.fromCache('../images/Tilemap/tilemap_packed.png');
    final spriteSheet = SpriteSheet(image: tiles, srcSize: Vector2.all(16));

    final spawnPointLayer = map.tileMap.getLayer<ObjectGroup>('SpawnPoint');
    final objects = spawnPointLayer?.objects;
    if (objects != null) {
      for (final object in objects) {
        switch (object.class_) {
          case 'Player':
            player = Player(
                position: Vector2(object.x, object.y),
                sprite: spriteSheet.getSprite(5, 10));
            await world.add(player);
            camera.follow(player);
            break;
          case 'Snowman':
            final snowman = SnowMan(
                position: Vector2(object.x, object.y),
                sprite: spriteSheet.getSprite(5, 9));
            await world.add(snowman);
            break;
          case 'Rock':
            final rock = RockComponent(
                onRetryPressed: onRetryPressed,
                position: Vector2(object.x, object.y),
                sprite: spriteSheet.getSprite(6, 9));
            await world.add(rock);
            break;
        }
      }
    }
  }

  Future<void> setupWorldAndCamera(TiledComponent<FlameGame<World>> map) async {
    world = World(children: [map, input]);
    await add(world);
    final leftButton = ArrowButton(isLeftBnt: true);
    final rightButton = ArrowButton(isLeftBnt: false);
    await add(leftButton);
    await add(rightButton);
    final pauseButton = ActionButton(
      imgButton: 'ButtonPause',
      actionButton: onPausePressed,
      position: Vector2(
        game.size.x - 30,
        1 + 30,
      ),
      size: Vector2.all(30),
    );
    add(pauseButton);
    //point
    final textPoint = TextComponent(
      text: 'Hello, Flame',
    )
      ..anchor = Anchor.topCenter
      ..x = 0 // size is a property from game
      ..y = 32;

    add(textPoint);
    //

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: 320,
      height: 180,
    );
    await add(camera);
  }

  Future<void> setupTrigger(TiledComponent<FlameGame<World>> map) async {
    final triggerLayer = map.tileMap.getLayer<ObjectGroup>('Trigger');
    final objects = triggerLayer?.objects;
    if (objects != null) {
      for (final object in objects) {
        switch (object.class_) {
          case 'Trail':
            final vertices = <Vector2>[];
            for (final point in object.polygon) {
              vertices.add(Vector2(point.x + object.x, point.y + object.y));
            }
            final hitbox = PolygonHitbox(
              vertices,
              collisionType: CollisionType.passive,
              isSolid: true,
            );
            await map.add(hitbox);
            break;
          case 'Danger':
            final vertices = <Vector2>[];
            for (final point in object.polygon) {
              vertices.add(Vector2(point.x + object.x, point.y + object.y));
            }
            final hitboxDanger = PolygonHitbox(
              vertices,
              collisionType: CollisionType.passive,
              isSolid: true,
            );

            hitboxDanger.onCollisionStartCallback = (_, __) {
              _resetPlayer();
            };
            await map.add(hitboxDanger);
            break;
          case 'Finished':
            final vertices = <Vector2>[];
            for (final point in object.polygon) {
              vertices.add(Vector2(point.x + object.x, point.y + object.y));
            }
            final hitboxFinish = PolygonHitbox(
              vertices,
              collisionType: CollisionType.passive,
              isSolid: true,
            )..debugMode = true;

            hitboxFinish.onCollisionStartCallback = (_, __) {
              onLevelComplete();
            }; // _,__ not used parameter
            await map.add(hitboxFinish);
            break;
        }
      }
    }
  }

  void _resetPlayer() {
    onRetryPressed();
  }

  void handleMoving(double dt) {
    _leftInput = lerpDouble(
      _leftInput,
      leftPressed ? 1.5 : 0,
      _sensitivity * dt,
    )!;

    _rightInput = lerpDouble(
      _rightInput,
      rightPressed ? 1.5 : 0,
      _sensitivity * dt,
    )!;

    hAxis = _rightInput - _leftInput;
  }
}
