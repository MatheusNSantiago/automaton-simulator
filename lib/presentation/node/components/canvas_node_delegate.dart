import 'package:flutter/material.dart';

import '../../../domain/model/node.dart';


class CanvasNodesDelegate extends MultiChildLayoutDelegate {
  CanvasNodesDelegate(this.nodes);
  final List<Node> nodes;

  @override
  void performLayout(Size size) {
    for (final node in nodes) {
      layoutChild(node, BoxConstraints.tight(node.size));
      positionChild(node, node.position.toOffset());
    }
  }

  @override
  bool shouldRelayout(CanvasNodesDelegate oldDelegate) => true;
}
