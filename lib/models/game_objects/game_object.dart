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
  });

  final String id;

  Component toComponent() {
    return Component();
  }

  GameObject copyFromComponent(Component component) {
    return GameObject(
      id: id,
    );
  }

  @override
  List<Object?> get props => [id];
}
