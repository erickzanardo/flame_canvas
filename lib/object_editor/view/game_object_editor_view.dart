import 'package:flame/game.dart';
import 'package:flame_canvas/models/game_objects/game_objects.dart';
import 'package:flame_canvas/object_editor/object_editor_game.dart';
import 'package:flutter/widgets.dart';

class GameObjectEditorPage extends StatelessWidget {
  const GameObjectEditorPage({
    required this.object,
    super.key,
  });

  final GameObject object;

  @override
  Widget build(BuildContext context) {
    if (object is GamePositionObject) {
      return GamePositionObjectEditorView(
        object: object as GamePositionObject,
      );
    } else {
      return const Center(
        child: Text('Unsupported (yet) object type'),
      );
    }
  }
}

class GamePositionObjectEditorView extends StatefulWidget {
  const GamePositionObjectEditorView({
    required this.object,
    super.key,
  });

  final GamePositionObject object;

  @override
  State<GamePositionObjectEditorView> createState() =>
      _GamePositionObjectEditorViewState();
}

class _GamePositionObjectEditorViewState
    extends State<GamePositionObjectEditorView> {
  late final PositionObjectEditorGame game;

  @override
  void initState() {
    super.initState();

    game = PositionObjectEditorGame(widget.object);
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
