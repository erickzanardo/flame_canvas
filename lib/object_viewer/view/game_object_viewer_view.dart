import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_canvas/models/game_objects/game_objects.dart';
import 'package:flutter/material.dart';

class GameObjectViewer extends StatelessWidget {
  const GameObjectViewer({
    required this.object,
    super.key,
  });

  final GameObject object;

  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(
      key: ValueKey(object.id),
      gameFactory: () {
        return GameObjectViewerGame(
          object,
        );
      },
    );
  }
}

class GameObjectViewerGame extends FlameGame {
  GameObjectViewerGame(this.object);

  final GameObject object;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final component = object.toComponent();

    if (component is PositionComponent) {
      component.anchor = Anchor.center;
    }

    world.add(component);
  }
}
