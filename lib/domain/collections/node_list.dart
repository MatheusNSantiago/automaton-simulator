import 'package:automata_simulator/constants.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NodeList extends Iterable<Node> with EquatableMixin {
  final Map<String, Node> _nodes;

  const NodeList(Map<String, Node> nodes) : _nodes = nodes;
  static const NodeList empty = NodeList({});

  void addNode(Point point) {
    var label = 'Q0';

    // nova label = valor da maior label + 1
    if (_nodes.isNotEmpty) {
      final lastLabel = _nodes.values.map((node) => node.label).sorted().last;
      label = 'Q${int.parse(lastLabel.substring(1)) + 1}';
    }

    Node node = Node(label: label, position: point)
        .translate(dx: -kNodeRadius, dy: -kNodeRadius); // centralizar

    _nodes[node.label] = node;
  }

  Node? getNodeOnPosition(Offset offset) {
    return this.firstWhereOrNull((node) => node.contains(offset));
  }

  Node? getNodeWithId(String id) => _nodes[id];

  @override
  Iterator<Node> get iterator => _nodes.values.iterator;
  @override
  List<Object?> get props => [_nodes];
  @override
  bool get stringify => true;
}
