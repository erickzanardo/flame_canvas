import 'package:flame_canvas/models/game_objects/game_objects.dart';
import 'package:flame_canvas/object_editor/object_editor.dart';
import 'package:flutter/material.dart';

class GameObjectEditorPage extends StatelessWidget {
  const GameObjectEditorPage({
    required this.object,
    super.key,
  });

  final GameObject object;

  static Route<GameObject?> route(GamePositionObject object) {
    return MaterialPageRoute<GameObject?>(
      builder: (_) => GameObjectEditorPage(
        object: object,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (object is GamePositionObject) {
      final positionObject = object as GamePositionObject;
      return Scaffold(
        body: GamePositionObjectEditorView(
          object: positionObject,
        ),
      );
    } else {
      return const Center(
        child: Text('Unsupported (yet) object type'),
      );
    }
  }
}
