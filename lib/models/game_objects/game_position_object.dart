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
  });

  final double width;
  final double height;

  @override
  PositionComponent toComponent() {
    return PositionComponent(
      size: Vector2(width, height),
    );
  }

  @override
  GameObject copyFromComponent(Component component) {
    if (component is! PositionComponent) {
      return super.copyFromComponent(component);
    }

    return GamePositionObject(
      id: id,
      width: component.size.x,
      height: component.size.y,
    );
  }

  @override
  List<Object?> get props => super.props + [width, height];
}
