import 'package:flame/game.dart';
import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SceneEditorView extends StatelessWidget {
  const SceneEditorView({
    required this.sceneId,
    super.key,
  });

  final String sceneId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppCubit>().state;
    if (state is LoadedState) {
      final scene =
          state.gameData.scenes.firstWhere((element) => element.id == sceneId);
      return _SceneEditorView(sceneId: scene);
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _SceneEditorView extends StatefulWidget {
  const _SceneEditorView({
    required this.sceneId,
  });

  final GameScene sceneId;

  @override
  State<_SceneEditorView> createState() => _SceneEditorViewState();
}

class _SceneEditorViewState extends State<_SceneEditorView> {
  late final GameSceneGame _game;

  @override
  void initState() {
    super.initState();
    _game = GameSceneGame(widget.sceneId);
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _game);
  }
}
