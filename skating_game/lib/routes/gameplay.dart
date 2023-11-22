import 'dart:async';

import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:skating_game/actors/snowman.dart';
import 'package:skating_game/routes/arrow_button.dart';
import 'package:skating_game/input.dart';
import 'package:skating_game/actors/player.dart';

class GamePlay extends Component with HasGameReference {
  GamePlay(
    this.currentLevel, {
    super.key,
    required this.onPausePressed,
    required this.onLevelComplete,
    required this.onRetryPressed,
  });
  static const id = 'GamePlay';
  int _nTrailTriggers = 0;
  bool get _isOffTrail => _nTrailTriggers == 0;
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
  late final _resetTimer = Timer(0.5, autoStart: false, onTick: _resetPlayer);
  late final World world;
  late final CameraComponent camera;
  late final Player player;
  late final Vector2 _playerSpawnPoint;

  @override
  void update(double dt) {
    if (_isOffTrail) {
      _resetTimer.update(dt);
      if (!_resetTimer.isRunning()) _resetTimer.start();
    } else {
      if (_resetTimer.isRunning()) _resetTimer.stop();
    }

    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    final map =
        await TiledComponent.load('Level-0$currentLevel.tmx', Vector2.all(16));

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
            _playerSpawnPoint = Vector2(object.x, object.y);
            await world.add(player);
            camera.follow(player);
            break;
          case 'Snowman':
            final snowman = SnowMan(
                position: Vector2(object.x, object.y),
                sprite: spriteSheet.getSprite(5, 9));
            await world.add(snowman);
            break;
        }
      }
    }
  }

  Future<void> setupWorldAndCamera(TiledComponent<FlameGame<World>> map) async {
    world = World(children: [map, input]);
    await add(world);
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
            )..debugMode = true;

            hitbox.onCollisionStartCallback =
                (_, __) => _onTrailEnter(); // _,__ not used parameter
            hitbox.onCollisionEndCallback = (_) => _onTrailExit();
            await map.add(hitbox);
            break;
          case 'Finished':
            var hitboxFinish = RectangleHitbox(
              size: Vector2(object.width, object.height),
              position: Vector2(object.x, object.y),
              collisionType: CollisionType.passive,
              isSolid: true,
            )
              ..debugMode = true
              ..debugColor = const Color(0xFF00FF00);
            hitboxFinish.onCollisionStartCallback = (_, __) {
              onLevelComplete();
            };
            await map.add(hitboxFinish);

            break;
        }
      }
    }
  }

  void _onTrailEnter() {
    ++_nTrailTriggers;
  }

  void _onTrailExit() {
    --_nTrailTriggers;
  }

  void _resetPlayer() {
    onRetryPressed();
  }
}
