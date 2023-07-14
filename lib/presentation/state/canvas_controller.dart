import 'dart:math';
import 'package:flutter/material.dart';
import 'app_controller.dart';

class CanvasController extends ChangeNotifier {
  final AppController app;
  late final transform = TransformationController();
  // double _scale = 1;
  double maxScale = 4;
  double minScale = 0.5;
  Size? viewport;

  CanvasController(this.app);

  // Matrix4 get matrix => transform.value;
  // double get scale => _scale;
  bool get canvasMoveEnabled => !app.mouse.mouseDown;

  Offset toLocal(Offset global) {
    return transform.toScene(global);
  }

  // set scale(double value) {
  //   if (value == _scale) return;
  //   _scale = value;
  //   app.notifyListeners();
  // }

  // double getScale() {
  //   final matrix = transform.value;
  //   final scaleX = matrix.getMaxScaleOnAxis();
  //   return scaleX;
  // }

  Rect getMaxSize() {
    Rect rect = Rect.zero;
    for (final node in app.nodes) {
      rect = Rect.fromLTRB(
        min(rect.left, node.rect.left),
        min(rect.top, node.rect.top),
        max(rect.right, node.rect.right),
        max(rect.bottom, node.rect.bottom),
      );
    }
    return rect;
  }

  // void zoom(double delta) {
  //   final matrix = transform.value.clone();
  //   final local = toLocal(app.mouse.mousePosition);
  //   matrix.translate(local.dx, local.dy);
  //   matrix.scale(delta, delta);
  //   matrix.translate(-local.dx, -local.dy);
  //   transform.value = matrix;
  //   app.notifyListeners();
  // }

  // void zoomIn() => zoom(1.1);
  // void zoomOut() => zoom(0.9);
  // void zoomReset() => transform.value = Matrix4.identity();

  void pan(Offset delta) {
    final matrix = transform.value.clone();
    matrix.translate(delta.dx, delta.dy);
    transform.value = matrix;
    app.notifyListeners();
  }

  // void panUp() => pan(const Offset(0, -10));
  // void panDown() => pan(const Offset(0, 10));
  // void panLeft() => pan(const Offset(-10, 0));
  // void panRight() => pan(const Offset(10, 0));

  // Offset getOffset() {
  //   final matrix = transform.value.clone();
  //   matrix.invert();
  //   final result = matrix.getTranslation();
  //   return Offset(result.x, result.y);
  // }

  // Rect getRect(BoxConstraints constraints) {
  //   final offset = getOffset();
  //   final scale = matrix.getMaxScaleOnAxis();
  //   final size = constraints.biggest;
  //   return offset & size / scale;
  // }
}
