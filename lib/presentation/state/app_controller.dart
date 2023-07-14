import 'package:flutter/material.dart';

import '../../domain/model/node.dart';
import '../../domain/model/link.dart';
import 'canvas_controller.dart';
import 'keyboard_controller.dart';
import 'link_controller.dart';
import 'mouse_controller.dart';
import 'node_controller.dart';
import 'selection_controller.dart';

class AppController extends ChangeNotifier {
  List<Node> nodes = [];
  List<Link> links = [];

  AppController({
    List<Node> nodes = const [],
    List<Link> links = const [],
  }) {
    if (nodes.isNotEmpty) {
      this.nodes.addAll(nodes);
    }
    if (links.isNotEmpty) {
      this.links.addAll(links);
    }
  }

  final focusNode = FocusNode();

  CanvasController get canvas => CanvasController(this);
  NodeController get node => NodeController(this);
  LinkController get link => LinkController(this);
  KeyboardController get keyboard => KeyboardController(this);
  MouseController get mouse => MouseController(this);
  SelectionController get selection => SelectionController(this);
}
