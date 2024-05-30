import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_canvas/models/game_scene.dart';

class GameSceneGame extends FlameGame {
  GameSceneGame(this.scene);

  final GameScene scene;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    // TODO
  }
}
