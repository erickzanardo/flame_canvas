import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/models/game_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SceneObjectViewer extends StatelessWidget {
  const SceneObjectViewer({
    required this.sceneObject,
    super.key,
  });

  final GameSceneObject sceneObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (sceneObject is GameScenePositionObject)
          _GameScenePositionObjectForm(
            key: ValueKey(sceneObject),
            sceneObject: sceneObject as GameScenePositionObject,
          ),
        const Divider(),
        IconButton(
          onPressed: () {
            final appCubit = context.read<AppCubit>();
            final editorCubit = context.read<EditorCubit>();

            appCubit.deleteSceneObject(
              sceneId: editorCubit.state.selectedScene!,
              sceneObjectId: sceneObject.id,
            );
            editorCubit.closeSceneObject();
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}

class _GameScenePositionObjectForm extends StatefulWidget {
  const _GameScenePositionObjectForm({
    required this.sceneObject,
    super.key,
  });

  final GameScenePositionObject sceneObject;

  @override
  State<_GameScenePositionObjectForm> createState() =>
      _GameScenePositionObjectFormState();
}

class _GameScenePositionObjectFormState
    extends State<_GameScenePositionObjectForm> {
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _xController.text = widget.sceneObject.x.toString();
    _yController.text = widget.sceneObject.y.toString();
    _priorityController.text = widget.sceneObject.priority.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        final state = current;
        if (previous is LoadedState && state is LoadedState) {
          final previousScene = previous.gameData.scenes
              .firstWhere((scene) => scene.id == widget.sceneObject.sceneId);

          final scene = state.gameData.scenes
              .firstWhere((scene) => scene.id == widget.sceneObject.sceneId);

          final previousObject = previousScene.gameObjects
              .firstWhere((obj) => obj.id == widget.sceneObject.id);

          final objects =
              scene.gameObjects.where((obj) => obj.id == widget.sceneObject.id);

          if (objects.isEmpty) {
            return false;
          }

          final object = objects.first;

          return previousObject != object;
        }
        return false;
      },
      listener: (context, state) {
        // Update the controllers
        if (state is LoadedState) {
          final scene = state.gameData.scenes
              .firstWhere((scene) => scene.id == widget.sceneObject.sceneId);

          final object = scene.gameObjects
              .firstWhere((obj) => obj.id == widget.sceneObject.id);

          if (object is GameScenePositionObject) {
            _xController.text = object.x.toString();
            _yController.text = object.y.toString();
          }
        }
      },
      child: Column(
        children: [
          TextField(
            controller: _xController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(labelText: 'X'),
            onChanged: (String value) {},
          ),
          TextField(
            controller: _yController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(labelText: 'Y'),
            onChanged: (String value) {},
          ),
          TextField(
            controller: _priorityController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(labelText: 'Priority'),
            onChanged: (String value) {},
          ),
        ],
      ),
    );
  }
}
