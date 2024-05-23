import 'package:equatable/equatable.dart';
import 'package:flame_canvas/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit() : super(const EditorState());

  void openObject(GamePositionObject object) {
    emit(state.selectObject(object.id));
  }

  void closeObject() {
    emit(state.unselectObject());
  }

  void openScene(GameScene scene) {
    emit(state.selectScene(scene.id));
  }

  void closeScene() {
    emit(state.unselectScene());
  }
}
