import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:path/path.dart' as path;

const libFolder = 'lib';
const flameCanvasFolder = 'flame_canvas';
const flameCanvasObjectsFolder = 'objects';
const flameCanvasScenesFolder = 'scenes';

/// Class responsible for generating the code for the objects and scenes.
class FlameCanvasService {
  Future<void> writeObjectCode(GameObject object, String projectPath) async {
    final objectsDirectory = Directory(
      path.join(
        projectPath,
        libFolder,
        flameCanvasFolder,
        flameCanvasObjectsFolder,
      ),
    );

    if (!objectsDirectory.existsSync()) {
      objectsDirectory.createSync(recursive: true);
    }

    final fileName = object.name.toSnakeCase();
    final file = File(
      path.join(
        objectsDirectory.path,
        '$fileName.dart',
      ),
    );

    await file.writeAsString(object.toCode());
  }

  Future<void> writeSceneCode({
    required GameScene scene,
    required List<GameObject> allObjects,
    required String projectPath,
  }) async {
    final scenesDirectory = Directory(
      path.join(
        projectPath,
        libFolder,
        flameCanvasFolder,
        flameCanvasScenesFolder,
      ),
    );

    if (!scenesDirectory.existsSync()) {
      scenesDirectory.createSync(recursive: true);
    }

    final fileName = scene.name.toSnakeCase();

    final file = File(
      path.join(
        scenesDirectory.path,
        '$fileName.dart',
      ),
    );

    await file.writeAsString(scene.toCode(allObjects));
  }
}
