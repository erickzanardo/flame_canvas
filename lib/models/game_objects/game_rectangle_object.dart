import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_canvas/models/models.dart';

GameRectangleObject createDefaultGameRecntagleObject() {
  return GameRectangleObject(
    id: generateGameObjectId(),
    width: 100,
    height: 100,
  );
}

class GameRectangleObject extends GamePositionObject {
  const GameRectangleObject({
    required super.id,
    required super.width,
    required super.height,
    this.color = 0xFFFFFFFF,
  });

  final int color;

  @override
  RectangleComponent toComponent() {
    return RectangleComponent(
      size: Vector2(width, height),
      paint: Paint()..color = Color(color),
    );
  }

  @override
  GameObject copyFromComponent(Component component) {
    if (component is! RectangleComponent) {
      return super.copyFromComponent(component);
    }

    return GameRectangleObject(
      id: id,
      width: component.size.x,
      height: component.size.y,
      color: component.paint.color.value,
    );
  }

  @override
  List<Object?> get props => super.props + [color];
}
