import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:uuid/uuid.dart';

String generateGameObjectId() {
  return const Uuid().v4();
}

GameObject createDefaultGameObject() {
  return GameObject(
    id: generateGameObjectId(),
    name: '',
  );
}

class GameObject extends Equatable {
  const GameObject({
    required this.id,
    required this.name,
  });

  factory GameObject.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final type = json['type'] as String?;

    if (type == 'position') {
      return GamePositionObject(
        id: id,
        name: name,
        width: json['width'] as double,
        height: json['height'] as double,
      );
    }

    if (type == 'rectangle') {
      return GameRectangleObject(
        id: id,
        name: name,
        width: json['width'] as double,
        height: json['height'] as double,
        color: json['color'] as int,
      );
    }

    return GameObject(
      id: id,
      name: name,
    );
  }

  final String id;
  final String name;

  Component toComponent() {
    return Component();
  }

  GameObject copyFromComponent(Component component) {
    return GameObject(
      id: id,
      name: name,
    );
  }

  GameObject copyWithName(String name) {
    return GameObject(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
