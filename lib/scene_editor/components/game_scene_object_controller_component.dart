import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/models/game_scene.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';

class GameSceneObjectControllerComponent extends RectangleComponent
    with
        ParentIsA<PositionComponent>,
        HasGameRef<GameSceneGame>,
        TapCallbacks,
        DragCallbacks {
  GameSceneObjectControllerComponent(this.gameSceneObject);

  final GameSceneObject gameSceneObject;

  bool _dragging = false;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _matchParentSize();

    parent.size.addListener(_matchParentSize);

    paint
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    add(
      FlameBlocListener<AppCubit, AppState>(
        listenWhen: (previous, current) {
          final state = current;
          if (state is LoadedState) {
            final scene = state.gameData.scenes
                .firstWhere((scene) => scene.id == gameSceneObject.sceneId);

            return scene.gameObjects
                .where((obj) => obj.id == gameSceneObject.id)
                .isEmpty;
          }
          return false;
        },
        bloc: gameRef.appCubit,
        onNewState: (state) {
          parent.removeFromParent();
        },
      ),
    );

    add(
      FlameBlocListener<EditorCubit, EditorState>(
        listenWhen: (previous, current) {
          return gameSceneObject.id == current.selectedSceneObject ||
              gameSceneObject.id == previous.selectedSceneObject;
        },
        bloc: gameRef.editorCubit,
        onNewState: (state) {
          if (gameSceneObject.id == state.selectedSceneObject) {
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

  void _selectSelf() {
    gameRef.editorCubit.openSceneObject(gameSceneObject.id);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    _selectSelf();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    _dragging = true;
    _selectSelf();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    if (_dragging) {
      parent.position.add(event.localDelta);
      gameRef.appCubit.updateGameSceneObjectPosition(
        gameSceneObjectId: gameSceneObject.id,
        sceneId: gameSceneObject.sceneId,
        x: parent.position.x,
        y: parent.position.y,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    _dragging = false;
  }
}
