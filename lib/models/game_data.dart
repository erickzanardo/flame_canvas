import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/game_scene.dart';

class GameData extends Equatable {
  const GameData({
    required this.scenes,
  });

  final List<GameScene> scenes;

  @override
  List<Object?> get props => [scenes];
}
