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
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.object.name;

    _game = PositionObjectEditorGame(widget.object);
    _game.mounted.then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GameWidget(game: _game),
        ),
        if (_game.isMounted)
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  PositionComponentForm(
                    object: widget.object,
                    component: _game.component,
                  ),
                  const SizedBox(height: 16),
                  SaveObjectForm(
                    buildObject: () => widget.object
                        .copyWithName(_nameController.text)
                        .copyFromComponent(
                          _game.component,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
