import 'package:equatable/equatable.dart';
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
}
