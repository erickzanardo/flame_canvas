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
    super.children,
  });

  final int color;

  @override
  RectangleComponent toComponent() {
    return RectangleComponent(
      size: Vector2(width, height),
      paint: Paint()..color = Color(color),
      children: children.map((child) => child.toComponent()).toList(),
    );
  }

  @override
  List<Object?> get props => super.props + [color];
}
