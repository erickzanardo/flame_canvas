import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  EditorCubit() : super(const EditorState());

  void openObject(String objectId) {
    emit(state.selectObject(objectId));
  }

  void closeObject() {
    emit(state.unselectObject());
  }

  void openScene(String? sceneId) {
    if (sceneId == null) {
      emit(state.unselectScene());
    } else {
      emit(state.selectScene(sceneId));
    }
  }
}
