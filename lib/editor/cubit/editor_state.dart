part of 'editor_cubit.dart';

class EditorState extends Equatable {
  const EditorState({
    this.selectedScene,
    this.selectedObject,
  });

  final String? selectedScene;
  final String? selectedObject;

  /// Selected a Scene
  EditorState selectScene(String sceneId) {
    return EditorState(
      selectedScene: sceneId,
      selectedObject: selectedObject,
    );
  }

  /// Selected an Object
  EditorState selectObject(String objectId) {
    return EditorState(
      selectedScene: selectedScene,
      selectedObject: objectId,
    );
  }

  /// Unselects the current Scene
  EditorState unselectScene() {
    return EditorState(
      selectedObject: selectedObject,
    );
  }

  /// Unselects the current Object
  EditorState unselectObject() {
    return EditorState(
      selectedScene: selectedScene,
    );
  }

  @override
  List<Object?> get props => [selectedScene, selectedObject];
}
