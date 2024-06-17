import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:flame_canvas/repository.dart';
import 'package:flame_canvas/service.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required ProjectRepository projectRepository,
    required FlameCanvasService flameCanvasService,
  })  : _projectRepository = projectRepository,
        _flameCanvasService = flameCanvasService,
        super(const InitialState());

  final ProjectRepository _projectRepository;
  final FlameCanvasService _flameCanvasService;

  Future<void> loadProject(String path) async {
    final gameData = await _projectRepository.loadProject(path);
    emit(
      LoadedState(
        gameData: gameData,
        projectPath: path,
      ),
    );
  }

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
      _projectRepository.saveObject(object, loadedState.projectPath);
      _flameCanvasService.writeObjectCode(object, loadedState.projectPath);
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
      _projectRepository.saveScene(scene, loadedState.projectPath);
      _flameCanvasService.writeSceneCode(
        scene: scene,
        allObjects: gameData.objects,
        projectPath: loadedState.projectPath,
      );
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
        _projectRepository.saveScene(scene, loadedState.projectPath);
        _flameCanvasService.writeSceneCode(
          scene: scene,
          allObjects: gameData.objects,
          projectPath: loadedState.projectPath,
        );
      }
    }
  }

  void deleteSceneObject({
    required String sceneId,
    required String sceneObjectId,
  }) {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;
      final gameData = loadedState.gameData;

      final scenes = gameData.scenes;
      final index = scenes.indexWhere((element) => element.id == sceneId);
      if (index != -1) {
        final scene = scenes[index];
        final gameObjects = scene.gameObjects;
        final newGameObjects = gameObjects.where(
          (element) => element.id != sceneObjectId,
        );

        final newScene = scene.copyWith(
          gameObjects: newGameObjects.toList(),
        );
        emit(
          loadedState.copyWith(
            gameData: gameData.copyWith(
              scenes: [
                ...scenes.sublist(0, index),
                newScene,
                ...scenes.sublist(index + 1),
              ],
            ),
          ),
        );
        _projectRepository.saveScene(newScene, loadedState.projectPath);
        _flameCanvasService.writeSceneCode(
          scene: newScene,
          allObjects: gameData.objects,
          projectPath: loadedState.projectPath,
        );
      }
    }
  }
}
