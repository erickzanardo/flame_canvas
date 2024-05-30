import 'package:flame/components.dart';
import 'package:flame_canvas/models/game_objects/game_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _widthController.text = widget.object.width.toInt().toString();
    _heightController.text = widget.object.height.toInt().toString();

    _widthController.addListener(_updateObjectDimensions);
    _heightController.addListener(_updateObjectDimensions);

    widget.component.size.addListener(_updateFormDimensions);
  }

  @override
  void dispose() {
    super.dispose();

    _widthController.dispose();
    _heightController.dispose();
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
    return Column(
      children: [
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
    );
  }
}
