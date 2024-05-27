import 'package:flame/components.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_canvas/models/game_objects/game_objects.dart';
import 'package:flame_canvas/object_editor/object_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameObjectEditorPage extends StatelessWidget {
  const GameObjectEditorPage({
    required this.object,
    super.key,
  });

  final GameObject object;

  static Route<void> route(GamePositionObject object) {
    return MaterialPageRoute<void>(
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

class PositionComponentForm extends StatefulWidget {
  const PositionComponentForm({
    required this.object,
    required this.component,
    super.key,
  });

  final GamePositionObject object;
  final PositionComponent component;

  @override
  State<PositionComponentForm> createState() => _PositionComponentFormState();
}

class _PositionComponentFormState extends State<PositionComponentForm> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _idController.text = widget.object.id;
    _widthController.text = widget.object.width.toInt().toString();
    _heightController.text = widget.object.height.toInt().toString();

    _widthController.addListener(_updateObjectDimensions);
    _heightController.addListener(_updateObjectDimensions);

    widget.component.size.addListener(_updateFormDimensions);
  }

  void _updateFormDimensions() {
    final newX = widget.component.size.x.toInt().toString();
    final newY = widget.component.size.y.toInt().toString();

    if (_widthController.text != newX) {
      _widthController.text = newX;
    }

    if (_heightController.text != newY) {
      _heightController.text = newY;
    }
  }

  void _updateObjectDimensions() {
    final newX = double.parse(_widthController.text);
    final newY = double.parse(_heightController.text);

    if (widget.component.size.x != newX) {
      widget.component.size.x = newX;
    }

    if (widget.component.size.y != newY) {
      widget.component.size.y = newY;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              enabled: false,
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Id',
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: _widthController,
              onChanged: (_) => _updateObjectDimensions(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Width',
              ),
            ),
            TextFormField(
              controller: _heightController,
              onChanged: (_) => _updateObjectDimensions(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Height',
              ),
            ),
          ],
        ),
      ),
    );
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
