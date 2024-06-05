import 'package:change_case/change_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:uuid/uuid.dart';

class GameSceneObject extends Equatable {
  const GameSceneObject({
    required this.id,
    required this.objectId,
    required this.priority,
  });

  factory GameSceneObject.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'position') {
      return GameScenePositionObject(
        id: json['id'] as String,
        objectId: json['objectId'] as String,
        priority: json['priority'] as int,
        x: json['x'] as double,
        y: json['y'] as double,
      );
    }

    return GameSceneObject(
      id: json['id'] as String,
      objectId: json['objectId'] as String,
      priority: json['priority'] as int,
    );
  }

  final String id;
  final String objectId;
  final int priority;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'objectId': objectId,
      'priority': priority,
    };
  }

  @override
  List<Object?> get props => [id, objectId, priority];
}

class GameScenePositionObject extends GameSceneObject {
  const GameScenePositionObject({
    required super.id,
    required this.x,
    required this.y,
    required super.objectId,
    required super.priority,
  });

  final double x;
  final double y;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'type': 'position',
        'x': x,
        'y': y,
      });
  }

  @override
  List<Object?> get props => super.props + [x, y];
}

class GameScene extends Equatable {
  const GameScene({
    required this.id,
    required this.name,
    required this.gameObjects,
  });

  factory GameScene.createNew(String name) {
    final id = const Uuid().v4();
    return GameScene(
      id: id,
      name: name,
      gameObjects: const [],
    );
  }

  factory GameScene.fromJson(Map<String, dynamic> json) {
    return GameScene(
      id: json['id'] as String,
      name: json['name'] as String,
      gameObjects: (json['gameObjects'] as List)
          .map((e) => GameSceneObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;

  final List<GameSceneObject> gameObjects;

  GameScene copyWith({
    String? id,
    String? name,
    List<GameSceneObject>? gameObjects,
  }) {
    return GameScene(
      id: id ?? this.id,
      name: name ?? this.name,
      gameObjects: gameObjects ?? this.gameObjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gameObjects': gameObjects.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, name, gameObjects];

  String toCode(List<GameObject> allObjects) {
    final objectsMap = <String, GameObject>{
      for (final object in allObjects) object.id: object,
    };

    final className = '\$${name.toCapitalCase()}';
    final buffer = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY MANUALLY')
      ..writeln("import 'package:flame/components.dart';")
      ..writeln("import 'package:flame/game.dart';")
      ..writeln('class $className extends FlameGame {')
      ..writeln('  $className();')
      ..writeln('  @override')
      ..writeln('  Future<void> onLoad() async {')
      ..writeln('    await super.onLoad();')
      ..writeln();

    // Used as a counter to generate unique variable names
    // from objects of the same object type.
    // TODO(erickzanardo): introduce a ref property in the GameSceneObject
    // so the user can give a specific name to the object in the game, which
    // can also be used as the component key.

    final variableCounters = <String, int>{};

    for (final sceneObject in gameObjects) {
      final gameObjectId = sceneObject.objectId;
      final gameObject = objectsMap[gameObjectId];

      if (gameObject == null) {
        throw Exception('Object with id $gameObjectId not found');
      }

      final variableName = '${gameObject.name.toCamelCase()}'
          '${variableCounters[gameObject.name] ?? ''}';

      variableCounters[gameObject.name] =
          (variableCounters[gameObject.name] ?? 0) + 1;

      // TODO(erickzanardo): add priority to the instantiation.
      buffer.writeln('    final $variableName =');

      if (gameObject is GamePositionObject &&
          sceneObject is GameScenePositionObject) {
        buffer
          ..writeln('      ${gameObject.codeClassName}(')
          ..writeln('        position: Vector2(')
          ..writeln('          ${sceneObject.x},')
          ..writeln('          ${sceneObject.y},')
          ..writeln('        ),')
          ..writeln('      );');
      }

      buffer.writeln('    world.add($variableName);');
    }

    buffer
      ..writeln('  }')
      ..writeln('}');

    return buffer.toString();
  }
}
