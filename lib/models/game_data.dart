import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';

class GameData extends Equatable {
  const GameData({
    required this.scenes,
    required this.objects,
  });

  final List<GameScene> scenes;
  final List<GameObject> objects;

  GameData copyWith({
    List<GameScene>? scenes,
    List<GameObject>? objects,
  }) {
    return GameData(
      scenes: scenes ?? this.scenes,
      objects: objects ?? this.objects,
    );
  }

  @override
  List<Object?> get props => [scenes, objects];
}
