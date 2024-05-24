import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:uuid/uuid.dart';

String generateGameObjectId() {
  return const Uuid().v4();
}

GameObject createDefaultGameObject() {
  return GameObject(id: generateGameObjectId());
}

class GameObject extends Equatable {
  const GameObject({
    required this.id,
    this.children = const <GameObject>[],
  });

  final List<GameObject> children;
  final String id;

  Component toComponent() {
    return Component(
      children: children.map((child) => child.toComponent()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, children];
}
