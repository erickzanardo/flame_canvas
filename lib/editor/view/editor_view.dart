import 'package:flame_canvas/app/cubit/app_cubit.dart';
import 'package:flame_canvas/editor/editor.dart';
import 'package:flame_canvas/editor/view/view.dart';
import 'package:flame_canvas/models/game_objects/game_object.dart';
import 'package:flame_canvas/models/game_objects/game_rectangle_object.dart';
import 'package:flame_canvas/object_editor/object_editor.dart';
import 'package:flame_canvas/scene_editor/scene_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => EditorCubit(),
        child: const EditorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditorView();
  }
}

class EditorView extends StatelessWidget {
  const EditorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: BlocBuilder<EditorCubit, EditorState>(
              buildWhen: (previous, current) =>
                  previous.selectedScene != current.selectedScene,
              builder: (context, state) {
                final selectedScene = state.selectedScene;

                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            final appCubit = context.read<AppCubit>();
                            final editorCubit = context.read<EditorCubit>();
                            final scene = await NewSceneDialog.show(context);

                            if (scene != null) {
                              appCubit.upsertScene(scene);
                              editorCubit.openScene(scene.id);
                            }
                          },
                        ),
                        BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            if (state is! LoadedState ||
                                state.gameData.scenes.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return DropdownMenu<String>(
                              initialSelection: selectedScene,
                              onSelected: (sceneId) {
                                context.read<EditorCubit>().openScene(sceneId);
                              },
                              dropdownMenuEntries: [
                                for (final scene in state.gameData.scenes)
                                  DropdownMenuEntry(
                                    value: scene.id,
                                    label: scene.name,
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: selectedScene == null
                          ? const Center(
                              child: Text('No scene selected'),
                            )
                          : SceneEditorView(
                              sceneId: selectedScene,
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: BlocBuilder<EditorCubit, EditorState>(
                    buildWhen: (previous, current) =>
                        previous.selectedObject != current.selectedObject,
                    builder: (context, state) {
                      final selectedObject = state.selectedObject;

                      if (selectedObject == null) {
                        return const Center(
                          child: Text('No object selected'),
                        );
                      } else {
                        return Center(
                          child: Text('Object: $selectedObject'),
                        );
                      }
                    },
                  ),
                ),
                const Divider(),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.add),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'rectangle',
                                child: Text('Add Rectangle Component'),
                              ),
                            ],
                            onSelected: (value) async {
                              final appCubit = context.read<AppCubit>();
                              Route<GameObject?>? route;
                              if (value == 'rectangle') {
                                route = GameObjectEditorPage.route(
                                  createDefaultGameRecntagleObject(),
                                );
                              }

                              if (route != null) {
                                final object =
                                    await Navigator.of(context).push(route);

                                if (object != null) {
                                  appCubit.upsertObject(object);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            if (state is! LoadedState) {
                              return const SizedBox.shrink();
                            }

                            return Column(
                              children: [
                                for (final object in state.gameData.objects)
                                  ListTile(
                                    title: Text(object.id),
                                    onTap: () {},
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
