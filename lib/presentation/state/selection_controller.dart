import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/material.dart';

import 'app_controller.dart';

class SelectionController extends ChangeNotifier {
  final AppController app;
  final Set<Key> _selected = {};
  Offset? marqueeStart, marqueeEnd;

  SelectionController(this.app);

  List<Node> get selections {
    return app.nodes.where((e) => _selected.contains(e.key)).toList();
  }

  bool get hasSelection => _selected.isNotEmpty;

  bool isSelected(LocalKey key) => _selected.contains(key);

  final Set<Key> _hovered = {};
  List<Node> get hovered =>
      app.nodes.where((e) => _hovered.contains(e.key)).toList();
  bool isHovered(LocalKey key) => _hovered.contains(key);

  void checkSelection(Point localPosition, [bool hover = false]) {
    final offset = localPosition.toOffset();
    final selection = <Key>[];
    for (final child in app.nodes) {
      final rect = child.rect;

      if (rect.contains(offset)) {
        selection.add(child.key);
      }
    }
    if (selection.isNotEmpty) {
      if (app.keyboard.shiftPressed) {
        setSelection({selection.last, ..._selected.toSet()}, hover);
      } else {
        setSelection({selection.last}, hover);
      }
    } else {
      deselectAll(hover);
    }
  }

  void checkMarqueeSelection([bool hover = false]) {
    if (marqueeStart == null || marqueeEnd == null) return;
    final selection = <Key>{};
    final rect = Rect.fromPoints(
      app.canvas.toLocal(marqueeStart!),
      app.canvas.toLocal(marqueeEnd!),
    );
    for (final child in app.nodes) {
      if (rect.overlaps(child.rect)) {
        selection.add(child.key);
      }
    }
    if (selection.isNotEmpty) {
      if (app.keyboard.shiftPressed) {
        setSelection(selection.union(_selected.toSet()), hover);
      } else {
        setSelection(selection, hover);
      }
    } else {
      deselectAll(hover);
    }
  }

  void moveSelection(Offset position) {
    final delta = app.mouse.mouseDragStart != null
        ? app.canvas.toLocal(position) -
            app.canvas.toLocal(app.mouse.mouseDragStart!)
        : app.canvas.toLocal(position);

    for (final key in _selected) {
      final index = app.nodes.indexWhere((e) => e.key == key);
      if (index == -1) continue;

      final node = app.nodes[index];
      // final origin = _selectedOrigins[key];
      // node.update(position: origin! + delta);
      // node.update(
      //     position: node.position.translate(dx: delta.dx, dy: delta.dy));

      // Atualizar links ligados a esse nó
      for (final link in app.links) {
        if (link.hasNode(node)) {
          link.update();
        }
      }
    }
    app.notifyListeners();
  }

  void select(Key key, [bool hover = false]) {
    if (hover) {
      _hovered.add(key);
    } else {
      _selected.add(key);
      // _cacheSelectedOrigin(key);
    }

    app.notifyListeners();
  }

  void setSelection(Set<Key> keys, [bool hover = false]) {
    if (hover) {
      _hovered.clear();
      _hovered.addAll(keys);
    } else {
      _selected.clear();
      _selected.addAll(keys);
      // _cacheSelectedOrigins();
    }

    // print("$_selected, ${app.nodes[0].key}, ${isSelected(app.nodes[0].key)}");
    app.notifyListeners();
  }

  void deselect(Key key, [bool hover = false]) {
    if (hover) {
      _hovered.remove(key);
    } else {
      _selected.remove(key);
      // _selectedOrigins.remove(key);
    }
    app.notifyListeners();
  }

  void deselectAll([bool hover = false]) {
    if (hover) {
      _hovered.clear();
    } else {
      _selected.clear();
      // _selectedOrigins.clear();
    }
    app.notifyListeners();
  }

  /* void deleteSelection() {
    final selection = _selected.toList();
    for (final key in selection) {
      final index = nodes.indexWhere((e) => e.key == key);
      if (index == -1) continue;
      nodes.removeAt(index);
      _selectedOrigins.remove(key);
    }
    // Delete related connections
    links.removeWhere(
      (e) => selection.contains(e.from.key) || selection.contains(e.to.key),
    );
    notifyListeners();
  } */

  /* void selectAll() {
    _selected.clear();
    _selected.addAll(app.nodes.map((e) => e.key).toList());
    // _cacheSelectedOrigins();
    notifyListeners();
  } */

  // final Map<Key, Offset> _selectedOrigins = {};
  // void _cacheSelectedOrigins() {
  //   // cache selected node origins
  //   _selectedOrigins.clear();
  //   for (final key in _selected) {
  //     final index = app.nodes.indexWhere((e) => e.key == key);
  //     if (index == -1) continue;
  //     final current = app.nodes[index];
  //     _selectedOrigins[key] = current.position;
  //   }
  // }

  // void _cacheSelectedOrigin(Key key) {
  //   final index = app.nodes.indexWhere((e) => e.key == key);
  //   if (index == -1) return;
  //   final current = app.nodes[index];
  //   _selectedOrigins[key] = current.position;
  // }
}
