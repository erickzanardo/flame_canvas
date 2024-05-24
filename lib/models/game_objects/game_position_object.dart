import 'package:flame/components.dart';
import 'package:flame_canvas/models/models.dart';

GamePositionObject createDefaultGamePositionObject() {
  return GamePositionObject(
    id: generateGameObjectId(),
    width: 100,
    height: 100,
  );
}

class GamePositionObject extends GameObject {
  const GamePositionObject({
    required super.id,
    required this.width,
    required this.height,
    super.children,
  });

  final double width;
  final double height;

  @override
  PositionComponent toComponent() {
    return PositionComponent(
      size: Vector2(width, height),
      children: children.map((child) => child.toComponent()).toList(),
    );
  }

  @override
  List<Object?> get props => super.props + [width, height];
}
