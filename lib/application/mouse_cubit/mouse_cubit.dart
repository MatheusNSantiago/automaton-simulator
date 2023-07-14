import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
part 'mouse_state.dart';

class MouseCubit extends Cubit<MouseState> {
  MouseCubit() : super(const MouseState());

  void setMousePosition(Offset value) => emit(state.copyWith(position: value));

  void down(int button) {
    switch (button) {
      case kPrimaryMouseButton:
        return emit(state.copyWith(isPrimaryDown: true));
      case kSecondaryMouseButton:
        return emit(state.copyWith(isSecondaryDown: true));
      default:
    }
  }

  void up() {
    return emit(
      state.copyWith(isPrimaryDown: false, isSecondaryDown: false),
    );
  }

  void setZoomInitialPosition(Offset value) {
    emit(state.copyWith(zoomInitialPosition: value));
  }
}
