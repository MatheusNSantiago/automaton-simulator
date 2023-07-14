import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/link.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/widgets.dart';

import 'app_controller.dart';

class LinkController extends ChangeNotifier {
  final AppController app;
  Point? _linkEnd;
  Node? linkStart;

  LinkController(this.app);

  void addLink(Node from, dynamic to, [String? label]) {
    final link = Link(from: from, to: to, label: label);
    app.links.add(link);
    app.notifyListeners();
  }


  Point? get linkEnd => _linkEnd;
  set linkEnd(Point? value) {
    if (value == _linkEnd) return;
    _linkEnd = value;
    app.notifyListeners();
  }
}
