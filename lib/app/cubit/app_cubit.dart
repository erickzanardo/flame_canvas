import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const LoadedState(
            gameData: GameData(
              scenes: [],
              objects: [],
            ),
          ),
        );

  void upsertObject(GameObject object) {
    if (state is LoadedState) {
      final gameData = (state as LoadedState).gameData;

      final objects = gameData.objects;
      final index = objects.indexWhere((element) => element.id == object.id);
      if (index == -1) {
        emit(
          LoadedState(
            gameData: gameData.copyWith(
              objects: [...objects, object],
            ),
          ),
        );
      } else {
        final newObjects = List<GameObject>.from(objects);
        newObjects[index] = object;
        emit(
          LoadedState(
            gameData: gameData.copyWith(
              objects: newObjects,
            ),
          ),
        );
      }
    }
  }
}
