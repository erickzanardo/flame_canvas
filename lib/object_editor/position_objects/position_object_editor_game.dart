import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_canvas/models/game_objects/game_position_object.dart';
import 'package:flame_canvas/object_editor/object_editor.dart';

class PositionObjectEditorGame extends FlameGame {
  PositionObjectEditorGame(this.object);

  final GamePositionObject object;

  late final PositionComponent component;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    camera.viewfinder.anchor = Anchor.center;

    world.add(
      component = object.toComponent()..anchor = Anchor.center,
    );

    component
      ..add(ResizeControlsComponent(vertical: true))
      ..add(ResizeControlsComponent(vertical: false));
  }
}
