import 'package:flutter/material.dart';
import 'app_controller.dart';

class MouseController extends ChangeNotifier {
  final AppController app;
  Offset mousePosition = Offset.zero;
  Offset? mouseDragStart;

  MouseController(this.app);

  bool _mouseDown = false;
  bool get mouseDown => _mouseDown;
  set mouseDown(bool value) {
    if (value == _mouseDown) return;
    _mouseDown = value;
    app.notifyListeners();
  }
}
