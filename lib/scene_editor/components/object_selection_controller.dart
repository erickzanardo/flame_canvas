import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';

class ObjectSelectionController extends PositionComponent
    with ParentIsA<PositionComponent>, HasGameRef<GameSceneGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _matchParentSize();

    parent.size.addListener(_matchParentSize);
  }

  @override
  void onRemove() {
    super.onRemove();
    parent.size.removeListener(_matchParentSize);
  }

  void _matchParentSize() {
    size.setFrom(parent.size);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    final sceneObjectId = gameRef.sceneObjects[parent];
    if (sceneObjectId == null) {
      return;
    }

    gameRef.editorCubit.openSceneObject(sceneObjectId);
  }
}
