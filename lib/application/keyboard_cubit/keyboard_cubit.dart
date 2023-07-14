import 'package:bloc/bloc.dart';
part 'keyboard_state.dart';

class KeyboardCubit extends Cubit<KeyboardState> {
  KeyboardCubit() : super(const KeyboardState());

  void shiftPressed(bool value) => emit(state.copyWith(shiftPressed: value));
  void spacePressed(bool value) => emit(state.copyWith(spacePressed: value));
  void controlPressed(bool value) =>
      emit(state.copyWith(controlPressed: value));
  void metaPressed(bool value) => emit(state.copyWith(metaPressed: value));

  @override
  void onChange(change) {
    super.onChange(change);
  }
}
