import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class GameSceneObject extends Equatable {
  const GameSceneObject({
    required this.id,
    required this.objectId,
    required this.priority,
  });

  final String id;
  final String objectId;
  final int priority;

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

  @override
  List<Object?> get props => [id, name, gameObjects];
}
