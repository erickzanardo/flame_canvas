import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_canvas/models/models.dart';

GameRectangleObject createDefaultGameRecntagleObject() {
  return GameRectangleObject(
    id: generateGameObjectId(),
    name: '',
    width: 100,
    height: 100,
  );
}

class GameRectangleObject extends GamePositionObject {
  const GameRectangleObject({
    required super.id,
    required super.name,
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
  GameRectangleObject copyWithName(String name) {
    return GameRectangleObject(
      id: id,
      name: name,
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  GameObject copyFromComponent(Component component) {
    if (component is! RectangleComponent) {
      return super.copyFromComponent(component);
    }

    return GameRectangleObject(
      id: id,
      name: name,
      width: component.size.x,
      height: component.size.y,
      color: component.paint.color.value,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'type': 'rectangle',
        'color': color,
      });
  }

  @override
  List<Object?> get props => super.props + [color];
}
