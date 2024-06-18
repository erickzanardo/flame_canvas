import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';
import 'package:uuid/uuid.dart';

class GameSceneGame extends FlameGame with TapCallbacks {
  GameSceneGame({
    required this.scene,
    required this.editorCubit,
    required this.appCubit,
  });

  final GameScene scene;
  final EditorCubit editorCubit;
  final AppCubit appCubit;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final appState = appCubit.state;

    if (appState is! LoadedState) {
      throw Exception('App state is not loaded');
    }

    for (final sceneObject in scene.gameObjects) {
      _addGameObject(sceneObject);
    }
  }

  void _addGameObject(GameSceneObject obj) {
    final gameObject = _getObjectById(obj.objectId);

    final component = (gameObject.toComponent())
      ..priority = obj.priority
      ..add(GameSceneObjectControllerComponent(obj));

    if (component is PositionComponent && obj is GameScenePositionObject) {
      component.position.x = obj.x;
      component.position.y = obj.y;
    }

    world.add(component);
  }

  GameObject _getObjectById(String id) {
    final appState = appCubit.state;

    if (appState is! LoadedState) {
      throw Exception('App state is not loaded');
    }

    return appState.gameData.objects.firstWhere(
      (element) => element.id == id,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    final selectedObjectId = editorCubit.state.selectedObject;

    if (selectedObjectId == null) {
      return;
    }

    final position =
        event.localPosition + camera.viewfinder.position - size / 2;

    final gameScenePositionObject = GameScenePositionObject(
      id: const Uuid().v4(),
      objectId: selectedObjectId,
      sceneId: scene.id,
      priority: 0,
      x: position.x,
      y: position.y,
    );

    _addGameObject(gameScenePositionObject);

    appCubit.addSceneObject(scene.id, gameScenePositionObject);
  }
}
