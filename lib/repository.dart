import 'dart:convert';
import 'dart:io';

import 'package:flame_canvas/models/models.dart';
import 'package:path/path.dart' as path;

const scenesFolder = 'scenes';
const objectsFolder = 'objects';
const rootFolder = '.flame_canvas';

class ProjectRepository {
  Future<GameData> loadProject(String projectPath) async {
    final rootDirectory = Directory(
      path.join(projectPath, rootFolder),
    );

    if (!rootDirectory.existsSync()) {
      return const GameData(scenes: [], objects: []);
    }

    final scenesDirectory = Directory(
      path.join(rootDirectory.path, scenesFolder),
    );

    final objectsDirectory = Directory(
      path.join(rootDirectory.path, objectsFolder),
    );

    final scenes = <GameScene>[];
    final objects = <GameObject>[];

    if (scenesDirectory.existsSync()) {
      final files = await scenesDirectory.list().toList();
      for (final file in files.whereType<File>()) {
        final content = await file.readAsString();
        final jsonContent = jsonDecode(content) as Map<String, dynamic>;
        final scene = GameScene.fromJson(jsonContent);
        scenes.add(scene);
      }
    }

    if (objectsDirectory.existsSync()) {
      final files = await objectsDirectory.list().toList();
      for (final file in files.whereType<File>()) {
        final content = await file.readAsString();
        final jsonContent = jsonDecode(content) as Map<String, dynamic>;
        final object = GameObject.fromJson(jsonContent);
        objects.add(object);
      }
    }

    return GameData(
      scenes: scenes,
      objects: objects,
    );
  }

  Future<void> saveScene(GameScene scene, String projectPath) async {
    final sceneDirectory = Directory(
      path.join(
        projectPath,
        rootFolder,
        scenesFolder,
      ),
    );

    if (!sceneDirectory.existsSync()) {
      sceneDirectory.createSync(recursive: true);
    }

    final sceneFile = File(
      path.join(
        sceneDirectory.path,
        '${scene.id}.json',
      ),
    );

    final sceneJson = jsonEncode(scene.toJson());
    await sceneFile.writeAsString(sceneJson);
  }

  Future<void> saveObject(GameObject object, String projectPath) async {
    final objectDirectory = Directory(
      path.join(
        projectPath,
        rootFolder,
        objectsFolder,
      ),
    );

    if (!objectDirectory.existsSync()) {
      objectDirectory.createSync(recursive: true);
    }

    final objectFile = File(
      path.join(
        objectDirectory.path,
        '${object.id}.json',
      ),
    );
    final objectJson = jsonEncode(object.toJson());
    await objectFile.writeAsString(objectJson);
  }
}
