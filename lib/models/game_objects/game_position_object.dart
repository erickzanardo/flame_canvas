import 'package:flame/components.dart';
import 'package:flame_canvas/models/models.dart';

GamePositionObject createDefaultGamePositionObject() {
  return GamePositionObject(
    id: generateGameObjectId(),
    name: '',
    width: 100,
    height: 100,
  );
}

class GamePositionObject extends GameObject {
  const GamePositionObject({
    required super.id,
    required super.name,
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
      name: name,
      width: component.size.x,
      height: component.size.y,
    );
  }

  @override
  GamePositionObject copyWithName(String name) {
    return GamePositionObject(
      id: id,
      name: name,
      width: width,
      height: height,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'type': 'position',
        'width': width,
        'height': height,
      });
  }

  @override
  List<Object?> get props => super.props + [width, height];
}
