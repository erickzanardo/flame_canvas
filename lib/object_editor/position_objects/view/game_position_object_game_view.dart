import 'package:flame/game.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:flame_canvas/object_editor/object_editor.dart';
import 'package:flutter/material.dart';

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
  late PositionObjectEditorGame _game;

  @override
  void initState() {
    super.initState();

    _game = PositionObjectEditorGame(widget.object);
    _game.loaded.then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GameWidget(game: _game),
        ),
        if (_game.isMounted)
          PositionComponentForm(
            object: widget.object,
            component: _game.component,
          ),
      ],
    );
  }
}
