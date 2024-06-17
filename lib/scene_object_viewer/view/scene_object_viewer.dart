import 'package:flame_canvas/models/game_scene.dart';
import 'package:flutter/widgets.dart';

class SceneObjectViewer extends StatelessWidget {
  const SceneObjectViewer({
    required this.sceneObject,
    super.key,
  });

  final GameSceneObject sceneObject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(sceneObject.id),
    );
  }
}
