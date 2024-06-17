part of 'editor_cubit.dart';

class EditorState extends Equatable {
  const EditorState({
    this.selectedSceneObject,
    this.selectedScene,
    this.selectedObject,
  });

  final String? selectedSceneObject;
  final String? selectedScene;
  final String? selectedObject;

  /// Selected a SceneObject
  EditorState selectSceneObject(String sceneObjectId) {
    return EditorState(
      selectedSceneObject: sceneObjectId,
      selectedScene: selectedScene,
      selectedObject: selectedObject,
    );
  }

  /// Selected a Scene
  EditorState selectScene(String sceneId) {
    return EditorState(
      selectedScene: sceneId,
      selectedObject: selectedObject,
      selectedSceneObject: selectedSceneObject,
    );
  }

  /// Selected an Object
  EditorState selectObject(String objectId) {
    return EditorState(
      selectedScene: selectedScene,
      selectedObject: objectId,
    );
  }

  /// Unselects the current SceneObject
  EditorState unselectSceneObject() {
    return EditorState(
      selectedObject: selectedObject,
      selectedScene: selectedScene,
    );
  }

  /// Unselects the current Scene
  EditorState unselectScene() {
    return EditorState(
      selectedObject: selectedObject,
      selectedSceneObject: selectedSceneObject,
    );
  }

  /// Unselects the current Object
  EditorState unselectObject() {
    return EditorState(
      selectedScene: selectedScene,
      selectedSceneObject: selectedSceneObject,
    );
  }

  @override
  List<Object?> get props => [
        selectedScene,
        selectedObject,
        selectedSceneObject,
      ];
}
