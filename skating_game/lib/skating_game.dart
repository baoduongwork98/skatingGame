import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;
import 'package:skating_game/routes/gameplay.dart';
import 'package:skating_game/routes/level_complete.dart';
import 'package:skating_game/routes/level_selection.dart';
import 'package:skating_game/routes/main_menu.dart';
import 'package:skating_game/routes/pause_menu.dart';
import 'package:skating_game/routes/retry_menu.dart';
import 'package:skating_game/routes/settings.dart';

class SkatingGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final musicValueNotifier = ValueNotifier(true);
  final sfxValueNotifier = ValueNotifier(true);

  late final _routes = <String, Route>{
    MainMenu.id: OverlayRoute(
      (context, game) => MainMenu(
        onPlayPressed: () => _routeById(LevelSelection.id),
        onSettingsPressed: () => _routeById(Settings.id),
      ),
    ),
    Settings.id: OverlayRoute(
      (context, game) => Settings(
        musicValueListenable: musicValueNotifier,
        sfxValueListenable: sfxValueNotifier,
        onMusicValueChanged: (value) => musicValueNotifier.value = value,
        onSfxValueChanged: (value) => sfxValueNotifier.value = value,
        onBackPressed: _popRoute,
      ),
    ),
    LevelSelection.id: OverlayRoute(
      (context, game) => LevelSelection(
        onLevelSelected: _startLevel,
        goBackPressed: _popRoute,
      ),
    ),
    PauseMenu.id: OverlayRoute(
      (context, game) => PauseMenu(
        onResumePressed: _resumeGame,
        onRestartPressed: _restartLevel,
        onExitPressed: _exitToMainMenu,
      ),
    ),
    LevelComplete.id: OverlayRoute(
      (context, game) => LevelComplete(
        onNextLevelPressed: _startNextLevel,
        onRestartPressed: _restartLevel,
        onExitPressed: _exitToMainMenu,
      ),
    ),
    RetryMenu.id: OverlayRoute(
      (context, game) => RetryMenu(
        onRetryPressed: _restartLevel,
        onExitPressed: _exitToMainMenu,
      ),
    ),
  };

  late final _router = RouterComponent(
    initialRoute: MainMenu.id,
    routes: _routes,
  );

  @override
  Color backgroundColor() => const Color.fromARGB(255, 238, 248, 254);

  @override
  Future<void> onLoad() async {
    await add(_router);
  }

  void _routeById(String id) {
    _router.pushNamed(id);
  }

  void _popRoute() {
    _router.pop();
  }

  void _startLevel(int levelIndex) {
    print('start level $levelIndex');
    _router.pop();
    _router.pushReplacement(
      Route(
        () => GamePlay(
          levelIndex,
          onPausePressed: _pauseGame,
          onLevelComplete: _showLevelCompleteMenu,
          onRetryPressed: _showRetryMenu,
          key: ComponentKey.named(GamePlay.id),
        ),
      ),
      name: GamePlay.id,
    );
  }

  void _restartLevel() {
    final gameplay = findByKeyName<GamePlay>(GamePlay.id);

    if (gameplay != null) {
      _startLevel(gameplay.currentLevel);
      resumeEngine();
    }
  }

  void _startNextLevel() {
    final gameplay = findByKeyName<GamePlay>(GamePlay.id);

    if (gameplay != null) {
      _startLevel(gameplay.currentLevel + 1);
      resumeEngine();
    }
  }

  void _pauseGame() {
    _router.pushNamed(PauseMenu.id);
    pauseEngine();
  }

  void _resumeGame() {
    _router.pop();
    resumeEngine();
  }

  void _exitToMainMenu() {
    _resumeGame();
    _router.pushReplacementNamed(MainMenu.id);
  }

  void _showLevelCompleteMenu() {
    pauseEngine();
    _router.pushNamed(LevelComplete.id);
  }

  void _showRetryMenu() {
    _router.pushNamed(RetryMenu.id);
  }
}
