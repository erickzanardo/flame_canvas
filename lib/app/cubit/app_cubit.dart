import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const LoadedState(gameData: GameData(scenes: [])));
}
