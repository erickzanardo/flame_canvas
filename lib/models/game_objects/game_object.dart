import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
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

  @override
  List<Object?> get props => [id, name];
}
