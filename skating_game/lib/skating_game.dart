import 'dart:async';
import 'dart:ffi';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skating_game/routes/choose_player.dart';
import 'package:skating_game/routes/gameplay.dart';
import 'package:skating_game/routes/level_complete.dart';
import 'package:skating_game/routes/level_selection.dart';
import 'package:skating_game/routes/main_menu.dart';
import 'package:skating_game/routes/pause_menu.dart';
import 'package:skating_game/routes/payment_menu.dart';
import 'package:skating_game/routes/retry_menu.dart';
import 'package:skating_game/routes/settings.dart';
import 'package:skating_game/utility.dart';

class SkatingGame extends FlameGame
    with TapCallbacks, HasKeyboardHandlerComponents, HasCollisionDetection {
  int score = 0;
  int countTurns = 0;
  final musicValueNotifier = ValueNotifier(true);
  final sfxValueNotifier = ValueNotifier(true);
  late final _routes = <String, Route>{
    MainMenu.id: OverlayRoute(
      (context, game) => MainMenu(
        countTurns: countTurns,
        onPlayPressed: () => playGame(),
        onSettingsPressed: () => _routeById(Settings.id),
        paymentPressed: () => _routeById(PaymentMenu.id),
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
        gameScore: score,
      ),
    ),
    ChoosePlayer.id: OverlayRoute(
      (context, game) => ChoosePlayer(
        onBackPressed: _exitToMainMenu,
      ),
    ),
    PaymentMenu.id: OverlayRoute(
      (context, game) => PaymentMenu(
        onBackPressed: _exitToMainMenu,
      ),
    )
  };

  late final _router = RouterComponent(
    initialRoute: MainMenu.id,
    routes: _routes,
  );

  @override
  Color backgroundColor() => const Color.fromARGB(255, 238, 248, 254);

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    await add(_router);
  }

  void _routeById(String id) {
    _router.pushNamed(id);
  }

  void _popRoute() {
    _router.pop();
  }

  void playGame() async {
    if (countTurns <= 0) {}
    _router.pushReplacement(
      Route(
        () => GamePlay(
          musicValueNotifier: musicValueNotifier,
          onPausePressed: _pauseGame,
          onLevelComplete: _showLevelCompleteMenu,
          onRetryPressed: _showRetryMenu,
          key: ComponentKey.named(GamePlay.id),
        ),
      ),
      name: GamePlay.id,
    );
  }

  void _startLevel(int levelIndex) async {
    _router.pop();
    playGame();
  }

  void _restartLevel() async {
    final gameplay = findByKeyName<GamePlay>(GamePlay.id);

    if (gameplay != null) {
      _startLevel(0);
      resumeEngine();
    }
  }

  Future<int> getScore() async {
    final gameplay = findByKeyName<GamePlay>(GamePlay.id);

    if (gameplay != null) {
      score = gameplay.score;
    }
    return score;
  }

  void _startNextLevel() async {
    final gameplay = findByKeyName<GamePlay>(GamePlay.id);

    if (gameplay != null) {
      _startLevel(0);
      resumeEngine();
    }
  }

  void _pauseGame() {
    _pushRouter(PauseMenu.id);
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
    _pushRouter(LevelComplete.id);
  }

  void _showRetryMenu() {
    if (musicValueNotifier.value) FlameAudio.play('disappear.wav', volume: 1.0);
    getScore();
    _pushRouter(RetryMenu.id);
  }

  void _pushRouter(String id) {
    pauseEngine();
    _router.pushNamed(id);
  }
}
