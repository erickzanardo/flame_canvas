import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const LoadedState(
            gameData: GameData(
              scenes: [],
              objects: [],
            ),
            projectPath: '',
          ),
        );

  void upsertObject(GameObject object) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;
      final gameData = loadedState.gameData;

      final objects = gameData.objects;
      final index = objects.indexWhere((element) => element.id == object.id);
      if (index == -1) {
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              objects: [...objects, object],
            ),
          ),
        );
      } else {
        final newObjects = List<GameObject>.from(objects);
        newObjects[index] = object;
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              objects: newObjects,
            ),
          ),
        );
      }
    }
  }

  void upsertScene(GameScene scene) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;
      final gameData = loadedState.gameData;

      final scenes = gameData.scenes;
      final index = scenes.indexWhere((element) => element.id == scene.id);
      if (index == -1) {
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              scenes: [...scenes, scene],
            ),
          ),
        );
      } else {
        final newScenes = List<GameScene>.from(scenes);
        newScenes[index] = scene;
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              scenes: newScenes,
            ),
          ),
        );
      }
    }
  }

  void addSceneObject(
    String id,
    GameScenePositionObject gameScenePositionObject,
  ) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;
      final gameData = loadedState.gameData;

      final scenes = gameData.scenes;
      final index = scenes.indexWhere((element) => element.id == id);
      if (index != -1) {
        final scene = scenes[index];
        final gameObjects = scene.gameObjects;
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              scenes: [
                ...scenes.sublist(0, index),
                scene.copyWith(
                  gameObjects: [...gameObjects, gameScenePositionObject],
                ),
                ...scenes.sublist(index + 1),
              ],
            ),
          ),
        );
      }
    }
  }
}
