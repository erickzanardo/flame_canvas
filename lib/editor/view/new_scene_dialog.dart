import 'package:flame_canvas/models/models.dart';
import 'package:flutter/material.dart';

class NewSceneDialog extends StatefulWidget {
  const NewSceneDialog({super.key});

  static Future<GameScene?> show(BuildContext context) async {
    return showDialog<GameScene>(
      context: context,
      builder: (context) {
        return const NewSceneDialog();
      },
    );
  }

  @override
  State<NewSceneDialog> createState() => _NewSceneDialogState();
}

class _NewSceneDialogState extends State<NewSceneDialog> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 400,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Create New Scene',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Scene Name',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text;
                        if (name.isEmpty) {
                          return;
                        }

                        Navigator.of(context).pop(GameScene.createNew(name));
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
