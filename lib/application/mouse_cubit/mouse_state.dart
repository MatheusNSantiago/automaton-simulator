part of 'mouse_cubit.dart';

class MouseState {
  final Offset position;
  final bool isPrimaryDown;
  final bool isSecondaryDown;
  bool get isPrimaryUp => !isPrimaryDown;
  bool get isSecondaryUp => !isSecondaryDown;
  bool get isDown => isPrimaryDown && isSecondaryDown;
  bool get isUp => isPrimaryUp && isSecondaryUp;

  const MouseState({
    this.position = Offset.zero,
    this.isPrimaryDown = false,
    this.isSecondaryDown = false,
  });

  MouseState copyWith({
    Offset? position,
    bool? isPrimaryDown,
    bool? isSecondaryDown,
  }) {
    return MouseState(
      position: position ?? this.position,
      isPrimaryDown: isPrimaryDown ?? this.isPrimaryDown,
      isSecondaryDown: isSecondaryDown ?? this.isSecondaryDown,
    );
  }

  @override
  String toString() {
    return 'MouseState(position: $position, isPrimaryDown: $isPrimaryDown, isSecondaryDown: $isSecondaryDown)';
  }
}
