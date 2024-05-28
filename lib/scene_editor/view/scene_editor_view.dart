import 'package:flutter/material.dart';

class SceneEditorView extends StatelessWidget {
  const SceneEditorView({
    required this.sceneId,
    super.key,
  });

  final String sceneId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(sceneId),
      ),
    );
  }
}
