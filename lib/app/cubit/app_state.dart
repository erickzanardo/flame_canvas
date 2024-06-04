part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class LoadedState extends AppState {
  const LoadedState({
    required this.gameData,
    required this.projectPath,
  });

  final GameData gameData;
  final String projectPath;

  LoadedState copyWith({
    GameData? gameData,
    String? projectPath,
  }) {
    return LoadedState(
      gameData: gameData ?? this.gameData,
      projectPath: projectPath ?? this.projectPath,
    );
  }

  @override
  List<Object?> get props => [gameData, projectPath];
}
