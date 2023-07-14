part of 'keyboard_cubit.dart';

class KeyboardState {
  final bool shiftPressed;
  final bool spacePressed;
  final bool controlPressed;
  final bool metaPressed;

  const KeyboardState({
    this.shiftPressed = false,
    this.spacePressed = false,
    this.controlPressed = false,
    this.metaPressed = false,
  });

  KeyboardState copyWith({
    bool? shiftPressed,
    bool? spacePressed,
    bool? controlPressed,
    bool? metaPressed,
  }) {
    return KeyboardState(
      shiftPressed: shiftPressed ?? this.shiftPressed,
      spacePressed: spacePressed ?? this.spacePressed,
      controlPressed: controlPressed ?? this.controlPressed,
      metaPressed: metaPressed ?? this.metaPressed,
    );
  }
}
