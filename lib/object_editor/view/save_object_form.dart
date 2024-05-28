import 'package:flame_canvas/models/models.dart';
import 'package:flutter/material.dart';

class SaveObjectForm extends StatelessWidget {
  const SaveObjectForm({
    required this.buildObject,
    super.key,
  });

  final GameObject Function() buildObject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          Navigator.of(context).pop(buildObject());
        },
      ),
    );
  }
}
