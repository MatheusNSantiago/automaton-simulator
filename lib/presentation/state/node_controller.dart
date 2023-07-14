import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../domain/model/node.dart';
import 'app_controller.dart';

class NodeController extends ChangeNotifier {
  final AppController app;

  NodeController(this.app);

  Node? getNode(LocalKey? key) {
    if (key == null) return null;
    return app.nodes.firstWhereOrNull((e) => e.key == key);
  }

  void add(Node child) {
    app.nodes.add(child);
    app.notifyListeners();
  }

  // void edit(Node child) {
  //   if (_selected.length == 1) {
  //     final idx = nodes.indexWhere((e) => e.key == _selected.first);
  //     nodes[idx] = child;
  //     notifyListeners();
  //   }
  // }

  // void remove(Key key) {
  //   nodes.removeWhere((e) => e.key == key);
  //   _selected.remove(key);
  //   _selectedOrigins.remove(key);
  //   notifyListeners();
  // }

  /* void bringToFront() {
    final selection = _selected.toList();
    for (final key in selection) {
      final index = nodes.indexWhere((e) => e.key == key);
      if (index == -1) continue;
      final current = nodes[index];
      nodes.removeAt(index);
      nodes.add(current);
    }
    notifyListeners();
  } */

  /* void sendBackward() {
    final selection = _selected.toList();
    if (selection.length == 1) {
      final key = selection.first;
      final index = nodes.indexWhere((e) => e.key == key);
      if (index == -1) return;
      if (index == 0) return;
      final current = nodes[index];
      nodes.removeAt(index);
      nodes.insert(index - 1, current);
      notifyListeners();
    }
  } */

  /* void sendForward() {
    final selection = _selected.toList();
    if (selection.length == 1) {
      final key = selection.first;
      final index = nodes.indexWhere((e) => e.key == key);
      if (index == -1) return;
      if (index == nodes.length - 1) return;
      final current = nodes[index];
      nodes.removeAt(index);
      nodes.insert(index + 1, current);
      notifyListeners();
    }
  } */

  /* void sendToBack() {
    final selection = _selected.toList();
    for (final key in selection) {
      final index = nodes.indexWhere((e) => e.key == key);
      if (index == -1) continue;
      final current = nodes[index];
      nodes.removeAt(index);
      nodes.insert(0, current);
    }
    notifyListeners();
  } */
}
