part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class LoadedState extends AppState {
  const LoadedState({
    required this.gameData,
  });

  final GameData gameData;

  @override
  List<Object?> get props => [gameData];
}
