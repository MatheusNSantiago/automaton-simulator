import 'package:flutter/foundation.dart';

import 'app_controller.dart';

class KeyboardController extends ChangeNotifier {
  final AppController app;

  KeyboardController(this.app);

  bool _shiftPressed = false;
  bool get shiftPressed => _shiftPressed;
  set shiftPressed(bool value) {
    if (value == _shiftPressed) return;
    _shiftPressed = value;
    app.notifyListeners();
  }

  bool _spacePressed = false;
  bool get spacePressed => _spacePressed;
  set spacePressed(bool value) {
    if (value == _spacePressed) return;
    _spacePressed = value;
    app.notifyListeners();
  }

  bool _controlPressed = false;
  bool get controlPressed => _controlPressed;
  set controlPressed(bool value) {
    if (value == _controlPressed) return;
    _controlPressed = value;
    app.notifyListeners();
  }

  bool _metaPressed = false;
  bool get metaPressed => _metaPressed;
  set metaPressed(bool value) {
    if (value == _metaPressed) return;
    _metaPressed = value;
    app.notifyListeners();
  }
}
