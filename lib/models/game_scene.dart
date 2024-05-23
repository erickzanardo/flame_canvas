import 'package:equatable/equatable.dart';

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

  final String id;
  final String name;

  final List<GameSceneObject> gameObjects;

  @override
  List<Object?> get props => [id, name, gameObjects];
}
