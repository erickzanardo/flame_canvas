import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';

class ObjectSelectionController extends RectangleComponent
    with ParentIsA<PositionComponent>, HasGameRef<GameSceneGame>, TapCallbacks {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _matchParentSize();

    parent.size.addListener(_matchParentSize);

    paint
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;


    // TODO remove self when object is deleted.

    add(
      FlameBlocListener<EditorCubit, EditorState>(
        listenWhen: (previous, current) {
          final id = sceneObjectId;
          return id == current.selectedSceneObject ||
              id == previous.selectedSceneObject;
        },
        bloc: gameRef.editorCubit,
        onNewState: (state) {
          if (sceneObjectId == state.selectedSceneObject) {
            paint.color = const Color(0x80FF0000);
          } else {
            paint.color = const Color(0x00000000);
          }
        },
      ),
    );
  }

  @override
  void onRemove() {
    super.onRemove();
    parent.size.removeListener(_matchParentSize);
  }

  void _matchParentSize() {
    size.setFrom(parent.size);
  }

  String get sceneObjectId {
    final sceneObjectId = gameRef.sceneObjects[parent];
    if (sceneObjectId == null) {
      throw Exception('Scene object not found');
    }

    return sceneObjectId;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    gameRef.editorCubit.openSceneObject(sceneObjectId);
  }
}
