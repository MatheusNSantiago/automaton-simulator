part of 'mouse_cubit.dart';

class MouseState {
  final Offset zoomInitialPosition;
  final bool isPrimaryDown;
  final bool isSecondaryDown;
  bool get isPrimaryUp => !isPrimaryDown;
  bool get isSecondaryUp => !isSecondaryDown;
  bool get isUp => isPrimaryUp && isSecondaryUp;

  const MouseState({
    this.zoomInitialPosition = Offset.zero,
    this.isPrimaryDown = false,
    this.isSecondaryDown = false,
  });

  MouseState copyWith({
    Offset? zoomInitialPosition,
    bool? isPrimaryDown,
    bool? isSecondaryDown,
  }) {
    return MouseState(
      zoomInitialPosition: zoomInitialPosition ?? this.zoomInitialPosition,
      isPrimaryDown: isPrimaryDown ?? this.isPrimaryDown,
      isSecondaryDown: isSecondaryDown ?? this.isSecondaryDown,
    );
  }

  @override
  String toString() {
    return 'MouseState(zoomInitialPosition: $zoomInitialPosition, isPrimaryDown: $isPrimaryDown, isSecondaryDown: $isSecondaryDown)';
  }
}
